# ------------------------------------------------
# Provider
# ------------------------------------------------
provider "aws" {
  region = "ap-south-1"
}

# ------------------------------------------------
# VPC Module
# ------------------------------------------------
module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr             = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  vpc_name             = "webapp-vpc"

  public_subnet_cidrs = {
    "ap-south-1a" = "10.0.1.0/24"
    "ap-south-1b" = "10.0.2.0/24"
  }

  private_subnet_cidrs = {
    "ap-south-1a" = "10.0.3.0/24"
    "ap-south-1b" = "10.0.4.0/24"
  }

  tags = {
    Environment = "dev"
    Project     = "web-app"
  }
}

# ------------------------------------------------
# Security Module
# ------------------------------------------------
module "security" {
  source = "../../modules/security"

  vpc_id   = module.vpc.vpc_id
  vpc_name = "webapp-vpc"

  tags = {
    Environment = "dev"
    Project     = "web-app"
  }
}

# ------------------------------------------------
# IAM Module
# ------------------------------------------------
module "iam" {
  source       = "../../modules/iam"
  project_name = "webapp"

  tags = {
    Environment = "dev"
    Project     = "web-app"
  }
}

# ------------------------------------------------
# Compute Module
# ------------------------------------------------
module "compute" {
  source = "../../modules/compute"

  private_subnet_ids         = module.vpc.private_subnet_ids
  public_subnet_ids          = module.vpc.public_subnet_ids
  db_sg_id                   = module.security.db_sg_id
  web_sg_id                  = module.security.web_sg_id
  iam_instance_profile_name  = module.iam.ec2_instance_profile_name
  instance_count             = 2
  instance_type              = "t3.micro"
  ami_id                     = "ami-0c02fb55956c7d316" # Amazon Linux 2 in ap-south-1
  project_name               = "webapp"

  tags = {
    Environment = "dev"
    Project     = "web-app"
  }
}

# ------------------------------------------------
# Database Module
# ------------------------------------------------
module "database" {
  source = "../../modules/database"

  private_subnet_ids = module.vpc.private_subnet_ids
  db_sg_id           = module.security.db_sg_id
  db_name            = "appdb"
  db_username        = "admin"
  db_password        = "SuperSecret123!"
  db_instance_class  = "db.t3.micro"
  db_engine          = "mysql"
  db_engine_version  = "8.0"
  project_name       = "webapp"

  tags = {
    Environment = "dev"
    Project     = "web-app"
  }
}

# ------------------------------------------------
# Monitoring Module
# ------------------------------------------------
module "monitoring" {
  source = "../../modules/monitoring"

  ec2_instance_ids = module.compute.ec2_instance_ids
  db_instance_id   = module.database.db_instance_id
  alb_arn          = module.compute.alb_arn
  project_name     = "webapp"

  tags = {
    Environment = "dev"
    Project     = "web-app"
  }
}
