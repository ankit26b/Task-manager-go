locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project
    Owner       = var.owner
  }
}

module "vpc" {
  source = "./modules/vpc"

  project              = var.project
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = local.common_tags
}

module "ec2" {
  source = "./modules/ec2"

  project             = var.project
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_id    = module.vpc.public_subnet_ids[0]
  instance_type       = var.ec2_instance_type
  key_name            = var.ec2_key_name
  allowed_ssh_cidr    = var.allowed_ssh_cidr
  backend_app_port    = var.backend_app_port
  tags                = local.common_tags
}

module "rds" {
  source = "./modules/rds"

  project                  = var.project
  environment              = var.environment
  vpc_id                   = module.vpc.vpc_id
  private_subnet_ids       = module.vpc.private_subnet_ids
  db_name                  = var.db_name
  db_username              = var.db_username
  db_password              = var.db_password
  db_allocated_storage     = var.db_allocated_storage
  db_instance_class        = var.db_instance_class
  db_multi_az              = var.db_multi_az
  db_backup_retention      = var.db_backup_retention_period
  db_deletion_protection   = var.db_deletion_protection
  allowed_security_group_id = module.ec2.security_group_id
  tags                     = local.common_tags
}

module "frontend_s3" {
  source = "./modules/s3"

  bucket_name = var.frontend_bucket_name
  tags        = local.common_tags
}

module "cloudfront" {
  source = "./modules/cloudfront"

  project                 = var.project
  environment             = var.environment
  s3_bucket_name          = module.frontend_s3.bucket_name
  s3_bucket_regional_name = module.frontend_s3.bucket_regional_domain_name
  tags                    = local.common_tags
}

# Creates remote-state resources so they can be managed in IaC.
# Bootstrap once with local state before migrating backend.
resource "aws_s3_bucket" "tf_state" {
  bucket = var.state_bucket_name

  lifecycle {
    prevent_destroy = true
  }

  tags = local.common_tags
}

resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = var.state_lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.common_tags
}
