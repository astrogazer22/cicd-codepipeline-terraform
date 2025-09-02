output "ec2_id" {
  value = aws_instance.instance.id
}

output "ec2_public_ip" {
  value = aws_instance.instance.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.instance.private_ip
}

output "ec2_type" {
  value = aws_instance.instance.instance_type
}

output "ec2_sg_id" {
  value = aws_instance.instance.security_groups
}

output "codepipeline_id" {
  value = aws_codepipeline.codepipeline.id
}

output "codepipeline_stage" {
  value = aws_codepipeline.codepipeline.stage
}

output "codebuild_arn" {
  value = aws_codebuild_project.nodejs_app_build.arn
}

output "codedeploy_arn" {
  value = aws_codedeploy_app.nodejs_app_deploy.arn
}

output "cloudwatch_metric_id" {
  value = aws_cloudwatch_metric_alarm.cpu_high.threshold_metric_id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.astrogazer-nodejs-s3-bucket.arn
}

output "sns_arn" {
  value = aws_sns_topic.alerts.application_success_feedback_role_arn
}
