provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI (Update with a valid AMI for your region)
  instance_type = "t2.micro"
  
  tags = {
    Name = "ExampleInstance"
  }
}
