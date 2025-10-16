variable "region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  default     = 2
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = "ami-0c2b8ca1dad447f8a"  # Update this for your region if needed
  instance_type = "t3.micro"

  tags = {
    Name = "example-instance-${count.index + 1}"
  }
}

output "instance_ids" {
  value = aws_instance.example[*].id
}
