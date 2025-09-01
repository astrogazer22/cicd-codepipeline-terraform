resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_vpc
  availability_zone = var.availability_zone

  tags = {
    Name = var.tag_subnet
  }
}
