#creating vpc
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block_vpc

  tags = {
    Name = "VPC"
  }
}

#creating public subnet
resource "aws_subnet" "public_subnet" {
  for_each = var.public_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags              = each.value["tags"]
}

#creating private subnet
resource "aws_subnet" "private_subnet" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags              = each.value["tags"]
}

#creating internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet Gateway"
  }
}

#elastic IP for NAT
resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "NAT Gateway EIP"
  }
}

#NAT gateway for VPC
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet["Public1"].id

  tags = {
    Name = "NAT Gateway"
  }
  depends_on = [
    aws_internet_gateway.igw
  ]
}

#route table for public
resource "aws_route_table" "public" {
  for_each = var.PublicRouteTable
  vpc_id   = aws_vpc.main.id

  dynamic "route" {
    for_each = var.PublicRouteTable
    content {
      cidr_block = var.cidr_block
      gateway_id = aws_internet_gateway.igw.id
    }
  }

  tags = {
    Name = "Public Route Table"
  }
}

#association public Subnet to Public Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet["Public1"].id
  route_table_id = aws_route_table.public["Public1"].id

}

#association public Subnet to Public Route Table 2
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet["Public2"].id
  route_table_id = aws_route_table.public["Public2"].id

}

#route table for private
resource "aws_route_table" "private" {
  for_each = var.PrivateRouteTable
  vpc_id   = aws_vpc.main.id

  dynamic "route" {
    for_each = var.PrivateRouteTable
    content {
      cidr_block = var.cidr_block
      nat_gateway_id = aws_nat_gateway.nat.id
    }
  }

  tags = {
    Name = "Private Route Table"
  }
}

#association private Subnet to private Route Table
resource "aws_route_table_association" "private" {

  subnet_id      = aws_subnet.private_subnet["Private1"].id
  route_table_id = aws_route_table.private["Private1"].id
}

#association private Subnet to private Route Table 2
resource "aws_route_table_association" "private2" {

  subnet_id      = aws_subnet.private_subnet["Private2"].id
  route_table_id = aws_route_table.private["Private2"].id
}