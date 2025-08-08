resource "aws_codebuild_project" "nodejs_app_build" {
  name          = "nodejs-app-build"
  description   = "Builds and packages the Node.js app"
  build_timeout = 5
  service_role  = aws_iam_role.codebuild_service_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"


  }


  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  tags = {
    Environment = "production"
    Project     = "ci-cd-demo"
  }
}
