resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.vpc.id

  tags = local.internet_gateway_tags
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = local.nat_gateway_tags
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[sort(keys(var.public_subnet_cidrs))[0]].id

  depends_on = [aws_internet_gateway.internet]

  tags = local.nat_gateway_tags
}
