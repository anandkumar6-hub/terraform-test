variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "aws_profile" {
  description = "AWS profile name"
  default     = "default"
}

variable "project_name" {
  description = "Project prefix for naming"
  default     = "tf-basic"
}

variable "env" {
  description = "Environment name"
  default     = "dev"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
}

variable "ami" {
  description = "AMI ID for Amazon Linux 2"
  default     = "ami-0dee22c13ea7a9a67"
}

variable "instance_type" {
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH"
  default     = "0.0.0.0/0"
}
