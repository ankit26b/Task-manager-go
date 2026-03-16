package models

type Task struct {
	ID int `json:"id"`
	Title string `json:"title" binding:"required"`
	Status string `json:"status"`
	Priority string    `json:"priority"`
	DueDate CustomTime `json:"due_date" swaggertype:"string"`
	CreatedAt CustomTime `json:"created_at" swaggertype:"string"`
	UpdatedAt CustomTime `json:"updated_at" swaggertype:"string"`
}
