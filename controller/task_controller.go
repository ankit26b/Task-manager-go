package controller

import (
	"net/http"
	"strconv"
	"task-manager/models"
	"task-manager/service"

	"github.com/gin-gonic/gin"
)

type TaskController struct {
	service *service.TaskService
}

func NewTaskController(service *service.TaskService) *TaskController {
	return &TaskController{service: service}
}

// CreateTask godoc
// @Summary Create a new task
// @Description Create a new task with title, description, priority and due date
// @Tags Tasks
// @Accept json
// @Produce json
// @Param task body models.Task true "Task object"
// @Success 201 {object} models.Task
// @Failure 400 {object} map[string]string
// @Router /tasks [post]
func (c *TaskController) CreateTask(ctx *gin.Context) {
	var task models.Task

	if err := ctx.ShouldBindJSON(&task); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	createdTask := c.service.CreateTask(task)
	ctx.JSON(http.StatusCreated, createdTask)
}

// GetTasks godoc
// @Summary Get all tasks
// @Description Get list of all tasks
// @Tags Tasks
// @Produce json
// @Success 200 {array} models.Task
// @Router /tasks [get]
func (c *TaskController) GetTasks(ctx *gin.Context) {
	tasks := c.service.GetTasks()
	ctx.JSON(http.StatusOK, tasks)
}

// GetTask godoc
// @Summary Get task by ID
// @Description Get a specific task by ID
// @Tags Tasks
// @Produce json
// @Param id path int true "Task ID"
// @Success 200 {object} models.Task
// @Failure 404 {object} map[string]string
// @Router /tasks/{id} [get]
func (c *TaskController) GetTask(ctx *gin.Context) {
	id, _ := strconv.Atoi(ctx.Param("id"))

	task, err := c.service.GetTask(id)
	if err != nil {
		ctx.JSON(http.StatusNotFound, gin.H{"error": "Task not found"})
		return
	}

	ctx.JSON(http.StatusOK, task)
}

// UpdateTask godoc
// @Summary Update task
// @Description Update existing task details
// @Tags Tasks
// @Accept json
// @Produce json
// @Param id path int true "Task ID"
// @Param task body models.Task true "Updated task"
// @Success 200 {object} models.Task
// @Failure 400 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Router /tasks/{id} [put]
func (c *TaskController) UpdateTask(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	var task models.Task
	if err := ctx.ShouldBindJSON(&task); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	updatedTask, err := c.service.UpdateTask(id, task)
	if err != nil {
		ctx.JSON(http.StatusNotFound, gin.H{"error": "Task not found"})
		return
	}

	ctx.JSON(http.StatusOK, updatedTask)
}

// DeleteTask godoc
// @Summary Delete task
// @Description Delete a task by ID
// @Tags Tasks
// @Produce json
// @Param id path int true "Task ID"
// @Success 200 {object} map[string]string
// @Failure 404 {object} map[string]string
// @Router /tasks/{id} [delete]
func (c *TaskController) DeleteTask(ctx *gin.Context) {
	id, _ := strconv.Atoi(ctx.Param("id"))

	err := c.service.DeleteTask(id)
	if err != nil {
		ctx.JSON(http.StatusNotFound, gin.H{"error": "Task not found"})
		return
	}

	ctx.Status(http.StatusNoContent)
}