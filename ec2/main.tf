resource "aws_instance" "instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = var.ec2_subnet_id
  security_groups      = [var.security_group_id]
  user_data            = file(var.ec2_user_data)
  iam_instance_profile = var.ec2_iam_instance_profile

  tags = {
    role = var.tag_role
    Name = var.tag_name
  }
}

# Create Elastic IP
resource "aws_eip" "web_eip" {
  domain = var.eip_domain
  tags = {
    Name = var.eip_name
  }
}

# Associate Elastic IP with your EC2 instance
resource "aws_eip_association" "web_eip_assoc" {
  instance_id   = aws_instance.instance.id
  allocation_id = aws_eip.web_eip.id
}
