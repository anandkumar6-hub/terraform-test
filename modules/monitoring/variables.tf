# EC2
variable "ec2_instance_ids" {
  type = list(string)
}

# RDS
variable "db_instance_id" {
  type = string
}

# ALB
variable "alb_arn" {
  type = string
}

# General
variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
