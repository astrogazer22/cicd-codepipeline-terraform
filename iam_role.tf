resource "aws_iam_role" "ec2_role" {
  name = "ec2_codedeploy_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
        "codedeploy:*",
        "s3:GetObject",
        "s3:ListBucket",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      Principal = {  
        Service = "ec2.amazonaws.com"
      },
      Effect = "Allow",
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_codedeploy_policy_attach" { 
  role = aws_iam_role.ec2_codedeploy_role.name 
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy" 
}

resource "aws_iam_role_policy_attachment" "ec2_full_access" { 
  role = aws_iam_role.ec2_codedeploy_role.name 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "s3_full_access" { 
  role = aws_iam_role.ec2_codedeploy_role.name 
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "s3_full_access" { 
  role = aws_iam_role.ec2_codedeploy_role.name 
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

resource "aws_iam_role_policy_attachment" "codedeploy_service_role_attach" { 
  role = aws_iam_role.ec2_codedeploy_role.name 
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

resource "aws_iam_instance_profile" "ec2_codedeploy_instance_profile" { 
  name = "EC2CodeDeployInstanceProfile" 
  role = aws_iam_role.ec2_codedeploy_role.name 
}
