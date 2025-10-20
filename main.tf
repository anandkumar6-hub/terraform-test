module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"


  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "web_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"
  ami = "ami-02d26659fd82cf299"

  instance_type = "t3.micro"
  key_name      = "ubuntukey"
  monitoring    = true
  subnet_id     = module.vpc.public_subnets[0]

  vpc_security_group_ids = [module.web_server_sg.security_group_id]


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}