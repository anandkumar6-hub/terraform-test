output "ec2_cpu_alarms" {
  value = [for alarm in aws_cloudwatch_metric_alarm.ec2_cpu : alarm.arn]
}
