terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  # Default tags are merged into every taggable AWS resource.
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project
      Owner       = var.owner
    }
  }
}
