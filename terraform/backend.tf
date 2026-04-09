terraform {
  backend "s3" {
    bucket         = "task-manager-dev-tf-state-change-me"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "task-manager-dev-tf-lock"
    encrypt        = true
  }
}

# Override these placeholders in CI/CD or per-environment via:
# terraform init -reconfigure \
#   -backend-config="bucket=<real-state-bucket>" \
#   -backend-config="key=<env>/terraform.tfstate" \
#   -backend-config="region=<aws-region>" \
#   -backend-config="dynamodb_table=<real-lock-table>" \
#   -backend-config="encrypt=true"
