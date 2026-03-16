package routes

import (
	"task-manager/controller"

	"github.com/gin-gonic/gin"
)

func corsMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "http://localhost:4200")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(204)
			return
		}
		c.Next()
	}
}

func SetupRoutes(r *gin.Engine, taskController *controller.TaskController) {
	r.Use(corsMiddleware())

	api := r.Group("/api")

	{
		api.GET("/tasks", taskController.GetTasks)
		api.GET("/tasks/:id", taskController.GetTask)
		api.POST("/tasks", taskController.CreateTask)
		api.PUT("/tasks/:id", taskController.UpdateTask)
		api.DELETE("/tasks/:id", taskController.DeleteTask)
	}
}
