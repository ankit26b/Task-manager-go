output "backend_public_ip" {
  description = "Public IP address of Node.js EC2 backend"
  value       = module.ec2.public_ip
}

output "backend_public_dns" {
  description = "Public DNS of Node.js EC2 backend"
  value       = module.ec2.public_dns
}

output "rds_endpoint" {
  description = "RDS MySQL endpoint"
  value       = module.rds.db_endpoint
}

output "rds_db_name" {
  description = "RDS database name"
  value       = module.rds.db_name
}

output "frontend_bucket_name" {
  description = "S3 bucket hosting frontend assets"
  value       = module.frontend_s3.bucket_name
}

output "cloudfront_domain_name" {
  description = "CloudFront URL for frontend"
  value       = module.cloudfront.domain_name
}

output "terraform_state_bucket" {
  description = "S3 bucket used for Terraform state"
  value       = aws_s3_bucket.tf_state.bucket
}

output "terraform_lock_table" {
  description = "DynamoDB table used for Terraform locking"
  value       = aws_dynamodb_table.tf_lock.name
}
