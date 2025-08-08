# Application
resource "aws_codedeploy_app" "nodejs_app_deploy" {
  name = "nodejs-app-deploy"
  compute_platform = "Server" 
}

# Deployment Group
resource "aws_codedeploy_deployment_group" "my_deploy_group" {
  app_name               = aws_codedeploy_app.nodejs-app.name
  deployment_group_name  = "nodejs-deployment-group"
  service_role_arn       = aws_iam_role.codedeploy_role.arn

  # Deployment config: e.g., CodeDeploy default "CodeDeployDefault.OneAtATime"
  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  # Target by EC2 Tag (recommended) - ensure EC2 instances have this tag
  ec2_tag_set {
    ec2_tag_filter {
      key   = "role"      # e.g., "Name" or "Role"
      type  = "KEY_AND_VALUE"
      value = "nodejs-deploy"    # e.g., "nodejs-app-server"
    }
  }

  # OPTIONAL: If using Auto Scaling groups:
  # auto_scaling_groups = [aws_autoscaling_group.my_asg.name]

  # File existence and lifecycle behavior
  trigger_configuration {
    trigger_events = ["DeploymentStart", "DeploymentSuccess", "DeploymentFailure"]
    trigger_name   = "notify-on-deploy"
    trigger_target_arn = aws_sns_topic.deploy_notifications.arn
  }

  # Auto rollback on failure (recommended)
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
