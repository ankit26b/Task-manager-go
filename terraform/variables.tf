variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Optional AWS CLI profile name (preferred for local usage)"
  type        = string
  default     = null
}

variable "aws_access_key_id" {
  description = "Optional AWS access key id (prefer environment variables in CI/CD)"
  type        = string
  sensitive   = true
  default     = null
}

variable "aws_secret_access_key" {
  description = "Optional AWS secret access key (prefer environment variables in CI/CD)"
  type        = string
  sensitive   = true
  default     = null
}

variable "aws_session_token" {
  description = "Optional AWS session token for temporary credentials"
  type        = string
  sensitive   = true
  default     = null
}

variable "environment" {
  description = "Deployment environment name (dev/prod)"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name used in tags and naming"
  type        = string
  default     = "task-manager"
}

variable "owner" {
  description = "Owner/team for operational ownership"
  type        = string
  default     = "platform-team"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.10.11.0/24", "10.10.12.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
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
  default     = "taskdb"
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = "task_admin"
}

variable "db_password" {
  description = "Master password for RDS (set via tfvars/env var)"
  type        = string
  sensitive   = true
  default     = "CHANGE_ME_PASSWORD"
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
  default     = "task-manager-dev-frontend-change-me"
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform remote state"
  type        = string
  default     = "task-manager-dev-tf-state-change-me"
}

variable "state_lock_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
  default     = "task-manager-dev-tf-lock"
}
