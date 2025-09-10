resource "aws_codepipeline" "codepipeline" {
  name     = "nodejs-app-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.codepipeline_artifact_location
    type     = "S3"
  }

  stage {
    name = var.codepipeline_stage_source

    action {
      name             = var.codepipeline_source_name
      category         = var.codepipeline_category_source
      owner            = var.codepipeline_source_owner
      provider         = var.codepipeline_source_provider
      version          = var.codepipeline_version
      output_artifacts = [var.codepipeline_source_output_artifacts]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github_connection.arn
        FullRepositoryId = var.codepipeline_repository
        BranchName       = var.codepipeline_branch_name

      }
    }
  }

  stage {
    name = var.codepipeline_build_stage

    action {
      name             = var.codepipeline_build_name
      category         = var.codepipeline_category_build
      owner            = var.codepipeline_build_owner
      provider         = var.codepipeline_build_provider
      input_artifacts  = [var.codepipeline_build_input_artifacts]
      output_artifacts = [var.codepipeline_build_output_artifacts]
      version          = var.codepipeline_version

      configuration = {
        ProjectName = var.codepipeline_project_name
      }
    }
  }

  stage {
    name = var.codepipeline_deploy_stage

    action {
      name            = var.codepipeline_deploy_name
      category        = var.codepipeline_category_deploy
      owner           = var.codepipeline_build_owner
      provider        = var.codepipeline_deploy_provider
      input_artifacts = [var.codepipeline_deploy_input_artifacts]
      version         = var.codepipeline_version

      configuration = {
        ApplicationName     = var.codepipeline_application_name
        DeploymentGroupName = var.codepipeline_deployment_group
      }
    }
  }

  lifecycle {
    # prevent github OAuthToken from causing updates, since it's removed from state file
    ignore_changes = [stage[0].action[0].configuration]
  }
}

resource "aws_codestarconnections_connection" "github_connection" {
  name          = var.aws_connection_name
  provider_type = var.aws_connection_provider_type
}

resource "aws_iam_role" "codepipeline_role" {
  name = "CodePipelineServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "CodePipelinePolicy"
  role = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # Actions that must NOT have a Resource
      {
        Effect = "Allow",
        Action = [
          "codepipeline:ListPipelines",
          "codepipeline:GetPipeline",
          "codepipeline:CreatePipeline",
          "codepipeline:DeletePipeline",
          "codepipeline:UpdatePipeline",
          "codepipeline:StartPipelineExecution",
          "codepipeline:GetPipelineState"
        ],
        Resource = "*"
      },
      # Actions that can have Resource
      {
        Effect = "Allow",
        Action = [
          "codestar-connections:UseConnection",
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codedeploy:CreateDeployment",
          "codedeploy:GetApplication",
          "codedeploy:GetDeployment",
          "codedeploy:GetDeploymentConfig",
          "codedeploy:RegisterApplicationRevision",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "codepipeline_policy" {
  name        = "codepipeline-policy"
  description = "Policy for AWS CodePipeline to interact with required services"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ],
        Resource = [
          "arn:aws:s3:::your-artifact-bucket-name",
          "arn:aws:s3:::your-artifact-bucket-name/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "codedeploy:CreateDeployment",
          "codedeploy:GetApplication",
          "codedeploy:GetDeploymentGroup"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "cloudwatch:*",
          "logs:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}
