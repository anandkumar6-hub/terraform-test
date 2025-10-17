provider "aws" {
  region = "ap-south-1"
}

variable "instance_name" {
  description = "name of the instance"
    default     = "ubuntu-server"
}

resource "aws_instance" "own_instance" {
    ami = "ami-02d26659fd82cf299"
    instance_type = "t3.micro"
    tags = {
        Name = var.instance_name
    }
}

output "instance_ids" {
  value = aws_instance.own_instance.id
}