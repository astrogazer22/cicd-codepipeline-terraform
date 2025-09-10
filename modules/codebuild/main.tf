
resource "aws_codebuild_project" "nodejs_app_build" {
  name          = "nodejs_app_build"
  description   = "Builds and packages the Node.js app"
  build_timeout = var.codebuild_timeout
  service_role  = aws_iam_role.codebuild_service_role.arn

  artifacts {
    type = var.codebuild_artifact
  }

  environment {
    compute_type                = var.codebuild_compute_type
    image                       = var.codebuild_image
    type                        = var.codebuild_container_type
    image_pull_credentials_type = var.codebuild_credential_type

  }

  source {
    type      = var.codebuild_source_type
    buildspec = var.codebuild_source_buildspec
  } 


  tags = {
    Environment = var.codebuild_environment_tag
    Project     = var.codebuild_project_tag
  }
}

resource "aws_iam_policy" "codebuild_policy" {
  name        = "codebuild_policy"
  description = "Permissions for CodeBuild project"

  # ✅ Resource field only inside IAM *permissions* policy
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:ap-southeast-1:696586991463:log-group:/aws/codebuild/nodejs_app_build:log-stream:*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetObjectVersion",
          "s3:GetBucketAcl",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::astrogazer-nodejs-s3-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_attach" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}

resource "aws_iam_role" "codebuild_service_role" {
  name = "codebuild_service_role"

  # Trust policy (no Resource field here)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
