# Create an SSH key pair from your local public key
resource "aws_key_pair" "deployer" {
key_name = var.key_name
public_key = file(var.public_key_path)
}


# Security group allowing SSH and HTTP
resource "aws_security_group" "web_sg" {
name = "tf-basic-web-sg"
description = "Allow SSH and HTTP"


ingress {
description = "SSH"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = [var.allowed_ssh_cidr]
}


ingress {
description = "HTTP"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}


# EC2 instance
resource "aws_instance" "web" {
ami = var.ami
instance_type = var.instance_type
key_name = aws_key_pair.deployer.key_name


vpc_security_group_ids = [aws_security_group.web_sg.id]


tags = {
Name = "tf-basic-web"
}


# Simple user_data to install nginx and serve a default page
user_data = <<-EOF
#!/bin/bash
amazon-linux-extras install -y nginx1
systemctl enable nginx
systemctl start nginx
echo "<h1>Terraform Basic Starter</h1><p>Deployed via Terraform</p>" > /usr/share/nginx/html/index.html
EOF
}