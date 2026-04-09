variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "s3_bucket_regional_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
