provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-06fa3f12191aa3337"  # Amazon Linux 2 AMI (Update with a valid AMI for your region)
  instance_type = "t3.micro"
  
  tags = {
    Name = "ExampleInstance"
  }
}
