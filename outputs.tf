output "ec2_public_ip" {
  value = module.ec2_instance.public_ip
  description = "Public IP of the EC2 instance"
}

output "security_group_id" {
  value = module.web_server_sg.security_group_id
  description = "Security Group ID attached to EC2"
}
