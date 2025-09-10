resource "aws_sns_topic" "deploy_notifications" {
  name = var.sns_name
}

resource "aws_sns_topic" "alerts" {
  name = var.sns_alert_name
}
