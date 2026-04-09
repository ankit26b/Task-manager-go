bucket         = "task-manager-prod-tf-state-change-me"
key            = "prod/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "task-manager-prod-tf-lock"
encrypt        = true
