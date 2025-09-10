# Application
resource "aws_codedeploy_app" "nodejs_app_deploy" {
  name             = "nodejs-app-deploy"
  compute_platform = var.codedeploy_compute_platform
}

# Deployment Group
resource "aws_codedeploy_deployment_group" "my_deploy_group" {
  app_name              = aws_codedeploy_app.nodejs_app_deploy.name
  deployment_group_name = var.codedeploy_deployment_group_name
  service_role_arn      = aws_iam_role.codedeploy_role.arn



  deployment_config_name = var.codedeploy_deployment_config_name

  # Ensure EC2 instances have this tag
  ec2_tag_set {
    ec2_tag_filter {
      key   = var.codedeploy_ec2_tag_key
      type  = var.codedeploy_ec2_tag_type
      value = var.codedeploy_ec2_tag_value
    }
  }


  trigger_configuration {
    trigger_events     = [var.codedeploy_start_event, var.codedeploy_success_event, var.codedeploy_failure_event]
    trigger_name       = var.codedeploy_trigger_name
    trigger_target_arn = var.codedeploy_trigger_target_arn
  }

  # Auto rollback on failure (recommended)
  auto_rollback_configuration {
    enabled = true
    events  = [var.codedeploy_auto_rollback_failure]
  }
}

resource "aws_iam_role" "codedeploy_role" {
  name               = var.codedeploy_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# IAM Role for CodeDeploy
resource "aws_iam_role" "codedeploy_service_role" {
  name = var.codedeploy_service_role_name

  # ✅ Trust policy for CodeDeploy (no Resource field here)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy for CodeDeploy
resource "aws_iam_policy" "codedeploy_policy" {
  name        = var.codedeploy_policy_name
  description = "Permissions for CodeDeploy to deploy applications"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Allow CodeDeploy to write logs
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      # Allow CodeDeploy to access S3 artifacts
      {
        Effect = "Allow"
        Action = [
          "s3:Get*",
          "s3:List*"
        ]
        Resource = [
          "arn:aws:s3:::your-artifact-bucket-name",
          "arn:aws:s3:::your-artifact-bucket-name/*"
        ]
      },
      # Allow CodeDeploy to interact with EC2 instances
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "autoscaling:Describe*",
          "autoscaling:UpdateAutoScalingGroup"
        ]
        Resource = "*"
      },
      # Allow CodeDeploy to use instance profiles
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "sns:Publish"
        ]
        Resource = "arn:aws:sns:ap-southeast-1:696586991463:nodejs-notifications"
      }
    ]
  })
}

# Attach policy to the role
resource "aws_iam_role_policy_attachment" "codedeploy_policy_attach" {
  role       = aws_iam_role.codedeploy_service_role.name
  policy_arn = aws_iam_policy.codedeploy_policy.arn
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = aws_iam_policy.codedeploy_policy.arn
  role       = aws_iam_role.codedeploy_role.name
}


