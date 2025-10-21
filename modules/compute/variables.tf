# Networking
variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

# Security
variable "web_sg_id" {
  type = string
}

variable "db_sg_id" {
  type = string
}

# IAM
variable "iam_instance_profile_name" {
  type = string
}

# EC2
variable "instance_count" {
  type    = number
  default = 2
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami_id" {
  type = string
}

# General
variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
