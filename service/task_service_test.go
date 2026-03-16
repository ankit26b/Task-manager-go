package service

import(
	"testing"
	"task-manager/models"
	"task-manager/repository"
)

func TestCreateTask(t *testing.T){
	repo := repository.NewTaskRepository()
	service := NewTaskService(repo)

	task:= models.Task{
		Title: "Test Task",
	}

	createdTask := service.CreateTask(task)

	if createdTask.ID != 1{
		t.Errorf("Expected task ID to be 1, got %d", createdTask.ID)
	}

	if createdTask.Status != "pending"{
		t.Errorf("Expected task status to be 'pending', got '%s'", createdTask.Status)
	}
}

func TestGetTasks(t *testing.T){
	repo := repository.NewTaskRepository()
	service := NewTaskService(repo)

	task:= models.Task{
		Title: "Test Task",
	}

	createdTask := service.CreateTask(task)

	feched, err := service.GetTask(createdTask.ID)

	if err != nil{
		t.Error("Unexpected error:", err)
	}

	if feched.Title != "Test Task"{
		t.Errorf("Expected task title to be 'Test Task', got '%s'", feched.Title)
	}

}

func TestDeleteTask(t *testing.T){
	repo := repository.NewTaskRepository()
	service := NewTaskService(repo)

	task := models.Task{
		Title: "Task to be deleted",
	}

	createdTask := service.CreateTask(task)

	err := service.DeleteTask(createdTask.ID)

	if err != nil{
		t.Errorf("Unexpected error: %v", err)
	}

	_, err = service.GetTask(createdTask.ID)

	if err == nil{
		t.Error("Expected error when fetching deleted task, got nil")
	}
}