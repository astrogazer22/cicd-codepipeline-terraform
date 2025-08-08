resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_instance" "instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.public.id
  security_groups      = [aws_security_group.sg.id]
  user_data            = file("ec2-user-data.sh")
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.role
  
  tags = {
    role = "nodejs-app-server"
  }
}

resource "aws_s3_bucket" "cicd-test-bucket" {
  bucket = "cicd-test-bucket"

  tags = {
    Name = "Test Bucket"
  }
}