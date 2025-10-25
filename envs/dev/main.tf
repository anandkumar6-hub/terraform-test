# ------------------------------------------------
# Provider
# ------------------------------------------------
provider "aws" {
  region = var.region
}

# ------------------------------------------------
# VPC Module
# ------------------------------------------------
module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr             = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  vpc_name             = "${var.project_name}-vpc"
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  single_nat_gateway   = var.single_nat_gateway

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# ------------------------------------------------
# Security Module
# ------------------------------------------------
module "security" {
  source = "../../modules/security"

  vpc_id   = module.vpc.vpc_id
  vpc_name = "${var.project_name}-vpc"

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# ------------------------------------------------
# IAM Module
# ------------------------------------------------
module "iam" {
  source       = "../../modules/iam"
  project_name = var.project_name

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# ------------------------------------------------
# Compute Module
# ------------------------------------------------
module "compute" {
  source = "../../modules/compute"

  vpc_id                     = module.vpc.vpc_id 
  private_subnet_ids         = module.vpc.private_subnet_ids
  public_subnet_ids          = module.vpc.public_subnet_ids
  db_sg_id                   = module.security.db_sg_id
  web_sg_id                  = module.security.web_sg_id
  iam_instance_profile_name  = module.iam.ec2_instance_profile_name
  instance_count             = var.instance_count
  instance_type              = var.instance_type
  ami_id                     = var.ami_id
  project_name               = var.project_name

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# ------------------------------------------------
# Database Module
# ------------------------------------------------
module "database" {
  source = "../../modules/database"

  private_subnet_ids = module.vpc.private_subnet_ids
  db_sg_id           = module.security.db_sg_id
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  db_instance_class  = var.db_instance_class
  db_engine          = var.db_engine
  db_engine_version  = var.db_engine_version
  project_name       = var.project_name

  tags = {
    Environment = var.environment
    Project     = var.project_name
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
  project_name     = var.project_name

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
