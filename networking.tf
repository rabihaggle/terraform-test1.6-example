
resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "VPC"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

}


resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myvpc.id

}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

}


resource "aws_route_table_association" "association_1" {
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.public.id
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  subnet_id     = aws_subnet.public.id
  allocation_id = aws_eip.nat_eip.id

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "r_private" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_route_table_association" "nat_private" {
  route_table_id = aws_route_table.r_private.id
  subnet_id      = aws_subnet.private.id

}
