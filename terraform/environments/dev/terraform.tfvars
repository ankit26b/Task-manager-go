aws_region  = "us-east-1"
aws_profile = "default"
environment = "dev"
project     = "task-manager"
owner       = "platform-team"

vpc_cidr             = "10.10.0.0/16"
public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
private_subnet_cidrs = ["10.10.11.0/24", "10.10.12.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

ec2_instance_type = "t3.micro"
ec2_key_name      = null
allowed_ssh_cidr  = "0.0.0.0/0"
backend_app_port  = 3000

db_name                    = "taskdb"
db_username                = "task_admin"
db_password                = "CHANGE_ME_DEV_PASSWORD"
db_allocated_storage       = 20
db_instance_class          = "db.t3.micro"
db_multi_az                = false
db_backup_retention_period = 3
db_deletion_protection     = false

frontend_bucket_name = "task-manager-dev-frontend-change-me"
state_bucket_name    = "task-manager-dev-tf-state-change-me"
state_lock_table_name = "task-manager-dev-tf-lock"
