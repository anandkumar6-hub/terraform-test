variable "aws_region" {
description = "AWS region to deploy into"
type = string
default = "ap-south-1"
}


variable "instance_type" {
description = "EC2 instance type"
type = string
default = "t3.micro"
}


variable "ami" {
description = "AMI ID to use for the EC2 instance (Amazon Linux 2)"
type = string
default = "ami-0dee22c13ea7a9a67" # example for ap-south-1; change if needed
}


variable "key_name" {
description = "Name for the SSH key pair in AWS (created by Terraform using your public key)"
type = string
}


variable "public_key_path" {
description = "Path to your local SSH public key (e.g., ~/.ssh/id_rsa.pub)"
type = string
default = "~/.ssh/id_rsa.pub"
}


variable "allowed_ssh_cidr" {
description = "CIDR allowed to access SSH (default: your IP or 0.0.0.0/0 for testing)"
type = string
default = "0.0.0.0/0"
}