output "ec2_instance_ids" {
  value = [for instance in aws_instance.app : instance.id]
}

output "alb_arn" {
  value = aws_lb.app_alb.arn
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.app_tg.arn
}

output "alb_listener_arn" {
  value = aws_lb_listener.app_listener.arn
}
