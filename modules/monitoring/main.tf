resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  count               = length(var.ec2_instance_ids)
  alarm_name          = "${var.project_name}-ec2-cpu-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alarm if CPU > 70% for 10 minutes"
  alarm_actions       = []
  dimensions = {
    InstanceId = var.ec2_instance_ids[count.index]
  }

  tags = merge(var.tags, { Name = "${var.project_name}-ec2-cpu-${count.index}" })
}
