package repository

import (
	"errors"
	"sync"
	"task-manager/models"
)

type TaskRepository struct {
	tasks  map[int]models.Task
	mu     sync.Mutex
	nextID int
}

func NewTaskRepository() *TaskRepository {
	return &TaskRepository{
		tasks:  make(map[int]models.Task),
		nextID: 1,
	}
}

func (r *TaskRepository) Create(task models.Task) models.Task {
	r.mu.Lock()
	defer r.mu.Unlock()

	task.ID = r.nextID
	r.nextID++
	r.tasks[task.ID] = task
	return task
}

func (r *TaskRepository) GetAll() []models.Task {
	r.mu.Lock()
	defer r.mu.Unlock()

	taskList := make([]models.Task, 0, len(r.tasks))
	for _, t := range r.tasks {
		taskList = append(taskList, t)
	}
	return taskList
}

func (r *TaskRepository) GetByID(id int) (models.Task, error) {
	r.mu.Lock()
	defer r.mu.Unlock()

	task, exists := r.tasks[id]
	if !exists {
		return models.Task{}, errors.New("task not found")
	}
	return task, nil
}

func (r *TaskRepository) Update(id int, updatedTask models.Task) (models.Task, error) {
	r.mu.Lock()
	defer r.mu.Unlock()

	task, exists := r.tasks[id]
	if !exists {
		return models.Task{}, errors.New("task not found")
	}

	task.Title = updatedTask.Title
	task.Status = updatedTask.Status
	task.Priority = updatedTask.Priority
	task.DueDate = updatedTask.DueDate
	task.UpdatedAt = updatedTask.UpdatedAt

	r.tasks[id] = task
	return task, nil
}

func (r *TaskRepository) Delete(id int) error {
	r.mu.Lock()
	defer r.mu.Unlock()

	if _, exists := r.tasks[id]; !exists {
		return errors.New("task not found")
	}
	delete(r.tasks, id)
	return nil
}
