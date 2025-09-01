# IAM Role for CodeDeploy
resource "aws_iam_role" "codedeploy_service_role" {
  name = "codedeploy_service_role"

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
  name        = "codedeploy_policy"
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

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = aws_iam_policy.codedeploy_policy.arn
  role       = aws_iam_role.codedeploy_role.name
}

# Attach policy to the role
resource "aws_iam_role_policy_attachment" "codedeploy_policy_attach" {
  role       = aws_iam_role.codedeploy_service_role.name
  policy_arn = aws_iam_policy.codedeploy_policy.arn
}
