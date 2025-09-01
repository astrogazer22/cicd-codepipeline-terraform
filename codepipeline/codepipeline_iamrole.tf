resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com"
        },
        Action = {
          sts                  = "AssumeRole",
          codepipeline         = "*",
          codestar-connections = "UseConnection",
          s3                   = "GetObject",
          s3                   = "GetObjectVersion",
          s3                   = "PutObject"
          codebuild            = "BatchGetBuilds",
          codebuild            = "StartBuild",
        },
        Resource = "*"
      },


    ]
  })
}
