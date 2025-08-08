resource "aws_codepipeline" "codepipeline" {
  name     = "nodejs-app-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.cicd-test-bucket.bucket
    type     = "S3"

    encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "GitHub"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.github_connection.arn
        FullRepositoryId     = "https://github.com/astrogazer22/cicd-codepipeline-terraform"
        BranchName           = "main"
        
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
         ProjectName = aws_codebuild_project.nodejs_app_build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ApplicationName     = aws_codedeploy_app.nodejs_app_deploy.name
        DeploymentGroupName = aws_codedeploy_deployment_group.my_deploy_group.deployment_group_name
      }
    }
  }

  lifecycle {
    # prevent github OAuthToken from causing updates, since it's removed from state file
    ignore_changes = [stage[0].action[0].configuration]
  }
}

resource "aws_codestarconnections_connection" "github_connection" {
  name          = "github_connection"
  provider_type = "GitHub"
}
