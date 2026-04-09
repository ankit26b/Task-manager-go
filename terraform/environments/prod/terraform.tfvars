aws_region  = "us-east-1"
environment = "prod"
project     = "task-manager"
owner       = "platform-team"

vpc_cidr             = "10.20.0.0/16"
public_subnet_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
private_subnet_cidrs = ["10.20.11.0/24", "10.20.12.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

ec2_instance_type = "t3.small"
ec2_key_name      = null
allowed_ssh_cidr  = "203.0.113.10/32"
backend_app_port  = 3000

db_name                    = "taskdb"
db_username                = "task_admin"
db_password                = "CHANGE_ME_PROD_PASSWORD"
db_allocated_storage       = 50
db_instance_class          = "db.t3.small"
db_multi_az                = true
db_backup_retention_period = 7
db_deletion_protection     = true

frontend_bucket_name  = "task-manager-prod-frontend-change-me"
state_bucket_name     = "task-manager-prod-tf-state-change-me"
state_lock_table_name = "task-manager-prod-tf-lock"
