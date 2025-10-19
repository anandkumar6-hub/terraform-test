terraform {
required_version = ">= 1.5.0"
required_providers {
aws = {
source = "hashicorp/aws"
version = ">= 5.0"
}
}
}


provider "aws" {
region = var.aws_region
}


# Uncomment and edit the backend if you created the S3 bucket with bootstrap script
# terraform {
# backend "s3" {
# bucket = "my-terraform-state-bucket-unique-name"
# key = "basic-starter/terraform.tfstate"
# region = "ap-south-1"
# dynamodb_table = "terraform-locks"
# encrypt = true
# }
# }