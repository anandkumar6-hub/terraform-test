variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
variable "project_name" {
  description = "Project name used as prefix for resource names"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}