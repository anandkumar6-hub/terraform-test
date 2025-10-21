variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Instance class for RDS"
  type        = string
}

variable "db_engine" {
  description = "Database engine type"
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnets for RDS"
  type        = list(string)
}

variable "db_sg_id" {
  description = "Security group ID for RDS"
  type        = string
}

variable "project_name" {
  description = "Project name tag"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}
