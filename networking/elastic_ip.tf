# Create Elastic IP
resource "aws_eip" "web_eip" {
  domain = "vpc"
  tags = {
    Name = "nodejs-web-eip"
  }
}

# Associate Elastic IP with your EC2 instance
resource "aws_eip_association" "web_eip_assoc" {
  instance_id   = aws_instance.instance.id
  allocation_id = aws_eip.web_eip.id
}
