variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type    = string
  default = null
}

variable "allowed_ssh_cidr" {
  type = string
}

variable "backend_app_port" {
  type = number
}

variable "tags" {
  type = map(string)
}
