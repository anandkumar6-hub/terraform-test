resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  for_each           = toset(var.ec2_instance_ids)
  alarm_name         = "${var.project_name}-ec2-cpu-${each.key}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alarm if CPU > 70% for 10 minutes"
  dimensions = {
    InstanceId = each.key
  }

  tags = merge(var.tags, { Name = "${var.project_name}-ec2-cpu" })
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  count              = length(var.ec2_instance_ids)
  alarm_name         = "CPUUtilization-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when CPU exceeds 80%"
  alarm_actions       = []
  dimensions = {
    InstanceId = var.ec2_instance_ids[count.index]
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name          = "${var.project_name}-alb-5xx"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Sum"
  threshold           = 5
  alarm_description   = "Alarm if ALB returns more than 5 5XX responses in 5 minutes"
  dimensions = {
    LoadBalancer = var.alb_arn
  }

  tags = merge(var.tags, { Name = "${var.project_name}-alb-5xx" })
}
