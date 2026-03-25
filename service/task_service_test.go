package service

import (
	"log"
	"os"
	"testing"

	"task-manager/models"
	"task-manager/repository"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func setupTestDB(t *testing.T) *gorm.DB {
	dsn := os.Getenv("TEST_DATABASE_URL")
	if dsn == "" {
		dsn = "host=localhost user=postgres password=postgres dbname=taskmanager_test port=5432 sslmode=disable"
	}
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		t.Fatalf("Failed to connect to test database: %v", err)
	}
	db.AutoMigrate(&models.Task{})
	// Clean table before each test
	db.Exec("TRUNCATE TABLE tasks RESTART IDENTITY CASCADE")
	log.Println("Test database ready")
	return db
}

func TestCreateTask(t *testing.T) {
	db := setupTestDB(t)
	repo := repository.NewTaskRepository(db)
	service := NewTaskService(repo)

	task := models.Task{
		Title: "Test Task",
	}

	createdTask := service.CreateTask(task)

	if createdTask.ID == 0 {
		t.Errorf("Expected task ID to be non-zero, got %d", createdTask.ID)
	}

	if createdTask.Status != "pending" {
		t.Errorf("Expected task status to be 'pending', got '%s'", createdTask.Status)
	}
}

func TestGetTasks(t *testing.T) {
	db := setupTestDB(t)
	repo := repository.NewTaskRepository(db)
	service := NewTaskService(repo)

	task := models.Task{
		Title: "Test Task",
	}

	createdTask := service.CreateTask(task)

	feched, err := service.GetTask(createdTask.ID)

	if err != nil {
		t.Error("Unexpected error:", err)
	}

	if feched.Title != "Test Task" {
		t.Errorf("Expected task title to be 'Test Task', got '%s'", feched.Title)
	}
}

func TestDeleteTask(t *testing.T) {
	db := setupTestDB(t)
	repo := repository.NewTaskRepository(db)
	service := NewTaskService(repo)

	task := models.Task{
		Title: "Task to be deleted",
	}

	createdTask := service.CreateTask(task)

	err := service.DeleteTask(createdTask.ID)

	if err != nil {
		t.Errorf("Unexpected error: %v", err)
	}

	_, err = service.GetTask(createdTask.ID)

	if err == nil {
		t.Error("Expected error when fetching deleted task, got nil")
	}
}