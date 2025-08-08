resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow tls for inbound traffic"
  vpc_id      = aws_vpc.main.id


  ingress {
    description     = "SSH from VPC"
    from_port       = var.port_22
    to_port         = var.port_22
    protocol        = var.protocol_tcp
    cidr_blocks     = [var.cidr_block_all]
    security_groups = [aws_security_group.lb_sg.id]
  }

  ingress {
    description     = "HTTP from VPC"
    from_port       = var.port_80
    to_port         = var.port_80
    protocol        = var.protocol_tcp
    cidr_blocks     = [var.cidr_block_all]
    security_groups = [aws_security_group.lb_sg.id]
  }

  ingress {
    description     = "HTTPS from VPC"
    from_port       = 443
    to_port         = 443
    protocol        = var.protocol_tcp
    cidr_blocks     = [var.cidr_block_all]
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
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
    description     = "HTTPS from VPC"
    from_port       = 443
    to_port         = 443
    protocol        = var.protocol_tcp
    cidr_blocks     = [var.cidr_block_all]
    security_groups = [aws_security_group.lb_sg.id]
  }

}