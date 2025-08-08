resource "aws_iam_role_policy_attachment" "codebuild_attach" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}
