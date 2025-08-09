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



resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}
