##############################
# VPC MODULE
##############################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 3.0.0"

  name = "${var.project_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_dns_hostnames = true

  tags = {
    Project     = var.project_name
    Environment = var.env
  }
}

##############################
# SECURITY GROUP
##############################
resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project     = var.project_name
    Environment = var.env
  }
}

##############################
# EC2 INSTANCE MODULE
##############################
module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">= 6.0.0"

  name                        = "${var.project_name}-web"
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install -y nginx1
    systemctl enable --now nginx
    echo "<h1>${var.project_name} - Deployed with Terraform</h1>" > /usr/share/nginx/html/index.html
  EOF

  tags = {
    Project     = var.project_name
    Environment = var.env
  }
}
