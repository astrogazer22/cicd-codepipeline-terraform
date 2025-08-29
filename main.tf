resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_instance" "instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.public.id
  security_groups      = [aws_security_group.sg.id]
  user_data            = file("ec2-user-data.sh")
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    role = "nodejs-deploy"
    Name = "nodejs-server-1"
  }
}

resource "aws_s3_bucket" "astrogazer-nodejs-s3-bucket" {
  bucket = "astrogazer-nodejs-s3-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
