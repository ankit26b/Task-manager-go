variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "task-manager-go"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (Amazon Linux 2 - ap-south-1)"
  type        = string
  default     = "ami-0736ad6363e77ba3b"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
