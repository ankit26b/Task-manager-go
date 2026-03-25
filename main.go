package main

// @title Task Management API
// @version 1.0
// @description This is a sample Task Management REST API built using Go, Gin, and Swagger.
// @host localhost:8080
// @BasePath /api

import(
	"github.com/gin-gonic/gin"

	"task-manager/config"
	"task-manager/controller"
	"task-manager/repository"
	"task-manager/routes"
	"task-manager/service"
	"github.com/gin-contrib/cors"

	swaggerFiles "github.com/swaggo/files"
    ginSwagger "github.com/swaggo/gin-swagger"
    _ "task-manager/docs"

)

func main(){
	r := gin.Default()

	r.Use(cors.New(cors.Config{
		AllowOrigins: []string{"http://localhost:4200"},
		AllowMethods: []string{"GET", "POST", "PUT", "DELETE"},
		AllowHeaders: []string{"Origin", "Content-Type"},
	}))

	db := config.InitDB()

	repo := repository.NewTaskRepository(db)
	service := service.NewTaskService(repo)
	controller := controller.NewTaskController(service)

	routes.SetupRoutes(r, controller)

	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	r.Run(":8080")
}