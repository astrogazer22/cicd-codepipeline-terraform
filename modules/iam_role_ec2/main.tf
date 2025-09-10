resource "aws_iam_role" "ec2_role" {
  name = "ec2_codedeploy_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow",
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attachments" {
  for_each   = toset(var.managed_policy_arns)
  role       = aws_iam_role.ec2_role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "this" {
  name = var.role_name
  role = aws_iam_role.ec2_role.name
}
