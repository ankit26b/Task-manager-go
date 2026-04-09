variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment name (dev/prod)"
  type        = string
}

variable "project" {
  description = "Project name used in tags and naming"
  type        = string
}

variable "owner" {
  description = "Owner/team for operational ownership"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
}

variable "ec2_instance_type" {
  description = "EC2 instance type for backend"
  type        = string
  default     = "t3.micro"
}

variable "ec2_key_name" {
  description = "Existing EC2 key pair name for SSH"
  type        = string
  default     = null
}

variable "allowed_ssh_cidr" {
  description = "CIDR range allowed to SSH into EC2"
  type        = string
  default     = "0.0.0.0/0"
}

variable "backend_app_port" {
  description = "Port exposed by the Node.js backend app"
  type        = number
  default     = 3000
}

variable "db_name" {
  description = "RDS MySQL database name"
  type        = string
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
}

variable "db_password" {
  description = "Master password for RDS (set via tfvars/env var)"
  type        = string
  sensitive   = true
}

variable "db_allocated_storage" {
  description = "Allocated RDS storage in GiB"
  type        = number
  default     = 20
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_multi_az" {
  description = "Whether to run RDS in Multi-AZ"
  type        = bool
  default     = false
}

variable "db_backup_retention_period" {
  description = "RDS backup retention in days"
  type        = number
  default     = 7
}

variable "db_deletion_protection" {
  description = "Protect DB from accidental deletion"
  type        = bool
  default     = true
}

variable "frontend_bucket_name" {
  description = "Globally unique S3 bucket name for frontend assets"
  type        = string
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform remote state"
  type        = string
}

variable "state_lock_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
}
