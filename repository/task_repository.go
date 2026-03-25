package repository

import (
	"task-manager/models"

	"gorm.io/gorm"
)

type TaskRepository struct {
	db *gorm.DB
}

func NewTaskRepository(db *gorm.DB) *TaskRepository {
	return &TaskRepository{db: db}
}

func (r *TaskRepository) Create(task models.Task) models.Task {
	r.db.Create(&task)
	return task
}

func (r *TaskRepository) GetAll() []models.Task {
	var tasks []models.Task
	r.db.Find(&tasks)
	return tasks
}

func (r *TaskRepository) GetByID(id int) (models.Task, error) {
	var task models.Task
	result := r.db.First(&task, id)
	if result.Error != nil {
		return models.Task{}, result.Error
	}
	return task, nil
}

func (r *TaskRepository) Update(id int, updatedTask models.Task) (models.Task, error) {
	var task models.Task
	result := r.db.First(&task, id)
	if result.Error != nil {
		return models.Task{}, result.Error
	}

	task.Title = updatedTask.Title
	task.Status = updatedTask.Status
	task.Priority = updatedTask.Priority
	task.DueDate = updatedTask.DueDate
	task.UpdatedAt = updatedTask.UpdatedAt

	r.db.Save(&task)
	return task, nil
}

func (r *TaskRepository) Delete(id int) error {
	result := r.db.Delete(&models.Task{}, id)
	if result.RowsAffected == 0 {
		return gorm.ErrRecordNotFound
	}
	return result.Error
}
