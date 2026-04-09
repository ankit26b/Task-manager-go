terraform {
  backend "s3" {}
}

# Backend is intentionally partial for CI/CD portability.
# Provide values via:
# terraform init \
#   -backend-config="bucket=<state-bucket-name>" \
#   -backend-config="key=<env>/terraform.tfstate" \
#   -backend-config="region=<aws-region>" \
#   -backend-config="dynamodb_table=<lock-table-name>" \
#   -backend-config="encrypt=true"
