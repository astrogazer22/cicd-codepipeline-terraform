resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Effect = "Allow",
    }]
  })
}

resource "aws_iam_policy" "s3_access" {
  name = "s3-access"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = ["s3:*"],
      Resource = ["arn:aws:s3:::${aws_s3_bucket.static_files.bucket}/*"],
      Effect   = "Allow"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}
