resource "aws_vpc" "main" {
  cidr_block = var.cidr_block_vpc
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_access"
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

resource "aws_iam_role_policy_attachment" "ec2_codedeploy_role_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = var.codedeploy_role_policy_arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = var.ec2_profile_head
  role = aws_iam_role.ec2_role.name
}

resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow tls for inbound traffic"
  vpc_id      = var.vpc_id


  ingress {
    description = "SSH from VPC"
    from_port   = var.port_22
    to_port     = var.port_22
    protocol    = var.protocol_tcp
    cidr_blocks = [var.cidr_block_all]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = var.port_80
    to_port     = var.port_80
    protocol    = var.protocol_tcp
    cidr_blocks = [var.cidr_block_all]
  }

  ingress {
    description = "HTTPS from VPC"
    from_port   = var.port_443
    to_port     = var.port_443
    protocol    = var.protocol_tcp
    cidr_blocks = [var.cidr_block_all]
  }

  egress {
    from_port        = var.null
    to_port          = var.null
    protocol         = var.protocol_all
    cidr_blocks      = [var.cidr_block_all]
    ipv6_cidr_blocks = [var.cidr_ipv6]
  }

  egress {
    description = "Rule to allow connections to database from any instances this security group is attached to"
    from_port   = var.port_3306
    to_port     = var.port_3306
    protocol    = var.protocol_tcp
    self        = false
  }

  egress {
    description = "HTTPS from VPC"
    from_port   = var.port_443
    to_port     = var.port_443
    protocol    = var.protocol_tcp
    cidr_blocks = [var.cidr_block_all]
  }

}
