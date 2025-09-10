output "alerts_action" {
  value = aws_sns_topic.alerts
}

output "notifications" {
  value = aws_sns_topic.deploy_notifications
}

output "sns_arn" {
  value = aws_sns_topic.deploy_notifications.arn
}
