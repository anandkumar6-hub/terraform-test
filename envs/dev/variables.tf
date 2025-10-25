// ------------------------------------------------
// Environment variables for dev
// ------------------------------------------------
variable "region" {
	description = "AWS region to deploy resources (e.g. ap-south-1)"
	type        = string
}

variable "environment" {
	description = "Environment name (e.g. dev, staging, prod)"
	type        = string
}

variable "project_name" {
	description = "Name of the project (used as a prefix for resource names)"
	type        = string
}

// ------------------------------------------------
// VPC Variables
// ------------------------------------------------
variable "vpc_cidr" {
	description = "CIDR block for the VPC"
	type        = string
}

variable "availability_zones" {
	description = "List of availability zones to create subnets in"
	type        = list(string)
}

variable "public_subnet_cidrs" {
	description = "Map of availability_zone -> CIDR for public subnets"
	type        = map(string)
}

variable "private_subnet_cidrs" {
	description = "Map of availability_zone -> CIDR for private subnets"
	type        = map(string)
}

variable "single_nat_gateway" {
	description = "Whether to use a single NAT gateway (cost saving) or one per AZ (highly available)"
	type        = bool
	default     = true
}

// ------------------------------------------------
// EC2 / Compute Variables
// ------------------------------------------------
variable "instance_type" {
	description = "EC2 instance type"
	type        = string
}

variable "instance_count" {
	description = "Number of EC2 instances"
	type        = number
}

variable "ami_id" {
	description = "AMI ID for EC2 instances"
	type        = string
}

// ------------------------------------------------
// Database Variables
// ------------------------------------------------
variable "db_name" {
	description = "Name of the database"
	type        = string
}

variable "db_username" {
	description = "Database username (avoid using root/admin for apps)"
	type        = string
}

variable "db_password" {
	description = "Database password (sensitive)"
	type        = string
	sensitive   = true
}

variable "db_instance_class" {
	description = "Database instance class"
	type        = string
}

variable "db_engine" {
	description = "Database engine (e.g. mysql, postgres)"
	type        = string
}

variable "db_engine_version" {
	description = "Database engine version"
	type        = string
}

// ------------------------------------------------
// Common/Optional Variables
// ------------------------------------------------
variable "tags" {
	description = "Map of tags to apply to resources"
	type        = map(string)
	default     = {}
}

variable "alb_log_bucket" {
	description = "S3 bucket name to store ALB access logs (optional)"
	type        = string
	default     = ""
}

