variable "vpc_cidr" {
  type       = string
}

variable "enable_dns_support" {
  type       = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Project     = "web-app"
  }
}

variable "vpc_name" {
  type       = string
}

variable "public_subnet_cidrs" {
  type = map(string)
  # Example:
  # default = {
  #   "ap-south-1a" = "10.0.1.0/24"
  #   "ap-south-1b" = "10.0.2.0/24"
  # }
}

variable "private_subnet_cidrs" {
  type = map(string)
  # Example:
  # default = {
  #   "ap-south-1a" = "10.0.101.0/24"
  #   "ap-south-1b" = "10.0.102.0/24"
  # }
}

variable "availability_zones" {
  type = list(string)
}

variable "single_nat_gateway" {
  type    = bool
  default = true
  description = "If false, one NAT gateway per AZ (highly available)."
}

