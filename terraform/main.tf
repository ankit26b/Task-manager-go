# Task Manager Go - Terraform Configuration

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider Configuration
provider "aws" {
  region = var.aws_region
}

# Security Group for the Task Manager App
resource "aws_security_group" "task_manager_sg" {
  name        = "${var.app_name}-sg"
  description = "Allow HTTP and SSH traffic for Task Manager"

  # Allow HTTP traffic on port 8080 (Go backend)
  ingress {
    description = "App traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH access
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-sg"
  }
}

# EC2 Instance to host the Task Manager app
resource "aws_instance" "task_manager" {
  ami           = var.ami_id
  instance_type = var.instance_type

  security_groups = [aws_security_group.task_manager_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y golang git

              # Clone the project
              cd /home/ec2-user
              git clone https://github.com/ankit26b/Task-manager-go.git
              cd Task-manager-go

              # Build the Go app
              go build -o task-manager .

              # Run the app in the background on port 8080
              nohup ./task-manager &
              EOF

  tags = {
    Name        = var.app_name
    Environment = var.environment
  }
}
