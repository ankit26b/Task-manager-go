package service

import(
	"time"
	"task-manager/models"
	"task-manager/repository"
)

type TaskService struct{
	repo *repository.TaskRepository
}

func NewTaskRepository(repo *repository.TaskRepository) *TaskService{
	return &TaskService{repo: repo}
}

func NewTaskService(repo *repository.TaskRepository) *TaskService {
	return &TaskService{repo: repo}
}

func (s *TaskService) CreateTask(task models.Task) models.Task{
	task.Status = "pending"
	task.CreatedAt = models.CustomTime{Time: time.Now()}
	task.UpdatedAt = models.CustomTime{Time: time.Now()}
	return s.repo.Create(task)
}

func (s *TaskService) GetTasks() []models.Task{
	return s.repo.GetAll()
}

func (s *TaskService) GetTask(id int) (models.Task, error){
	return s.repo.GetByID(id)
}

func (s *TaskService) UpdateTask(id int, task models.Task) (models.Task, error) {
	task.UpdatedAt = models.CustomTime{Time: time.Now()}
	return s.repo.Update(id, task)
}

func (s *TaskService) DeleteTask(id int) error{
	return s.repo.Delete(id)
}