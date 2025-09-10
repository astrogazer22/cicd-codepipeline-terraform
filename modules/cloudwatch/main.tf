
resource "aws_cloudwatch_log_group" "ec2_logs" {
  name              = var.cloudwatch_log_path
  retention_in_days = var.log_retention_period
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.cloudwatch_evaluation_period
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.metric_period
  statistic           = var.metric_statistic
  threshold           = var.metric_threshold
  alarm_description   = "This alarm triggers if CPU usage exceeds ${var.metric_threshold} for ${var.metric_period} minutes"

  dimensions = {
    InstanceId = var.cloudwatch_instance_id
  }
}






