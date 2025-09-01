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
