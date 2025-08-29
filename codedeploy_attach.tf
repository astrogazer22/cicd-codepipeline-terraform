resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = aws_iam_policy.codedeploy_policy.arn
  role       = aws_iam_role.codedeploy_role.name
}
