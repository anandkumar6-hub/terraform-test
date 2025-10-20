output "ec2_cpu_alarms" {
  value = [for alarm in aws_cloudwatch_metric_alarm.ec2_cpu : alarm.arn]
}

output "rds_cpu_alarm" {
  value = aws_cloudwatch_metric_alarm.rds_cpu.arn
}

output "alb_5xx_alarm" {
  value = aws_cloudwatch_metric_alarm.alb_5xx.arn
}
