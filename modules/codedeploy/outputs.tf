output "codedeploy_nodejs_app_name" {
  value = aws_codedeploy_app.nodejs_app_deploy.name
}

output "codedeploy_deployment_group_name" {
  value = aws_codedeploy_deployment_group.my_deploy_group.app_name
}
