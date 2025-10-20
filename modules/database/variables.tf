# Networking
variable "private_subnet_ids" {
  type = list(string)
}

variable "db_sg_id" {
  type = string
}

# DB Config
variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type    = string
  sensitive = true
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "db_engine_version" {
  type    = string
  default = "8.0"
}

# General
variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "appdb"   # optional default
}
