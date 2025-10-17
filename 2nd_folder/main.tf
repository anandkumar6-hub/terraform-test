variable "instances" {
  description = "Different EC2 instances with OS and instance type"
  type = map(object({
    ami           = string
    instance_type = string
  }))

  default = {
    ubuntu = {
      ami           = "ami-02d26659fd82cf299"  # Ubuntu 22.04 LTS (us-east-1)
      instance_type = "t3.micro"
    },
    amazon_linux = {
      ami           = "ami-06fa3f12191aa3337"  # Amazon Linux 2 (us-east-1)
      instance_type = "t3.micro"
    },
    windows = {
      ami           = "ami-066eb5725566530f0"  # Windows Server 2019 Base (us-east-1)
      instance_type = "t3.micro"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "multi_os" {
  for_each      = var.instances
  ami           = each.value.ami
  instance_type = each.value.instance_type

  tags = {
    Name = "${each.key}-server"
  }
}

output "instance_ids" {
  value = { for k, v in aws_instance.multi_os : k => v.id }
}
