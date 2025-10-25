# AWS and Environment
region       = "ap-south-1"
environment  = "dev"
project_name = "webapp"

# VPC
vpc_cidr     = "10.0.0.0/16"
availability_zones = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidrs = {
  "ap-south-1a" = "10.0.1.0/24"
  "ap-south-1b" = "10.0.2.0/24"
}
private_subnet_cidrs = {
  "ap-south-1a" = "10.0.101.0/24"
  "ap-south-1b" = "10.0.102.0/24"
}
single_nat_gateway = true

# Compute
instance_type  = "t3.micro"
instance_count = 2
ami_id         = "ami-06fa3f12191aa3337"  # Amazon Linux 2 in ap-south-1

# Database
db_name           = "appdb"
db_username       = "admin"
db_password       = "SuperSecret123!"      # Change this in production!
db_instance_class = "db.t3.micro"
db_engine         = "mysql"
db_engine_version = "8.0"