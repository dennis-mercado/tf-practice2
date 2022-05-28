###############################################################################
# Data Source
###############################################################################
data "aws_availability_zones" "available" {
  filter {
    name   = "region-name"
    values = [var.region]
  }
}

###############################################################################
# VPC
###############################################################################
resource "aws_vpc" "VPC" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "TestVPC"
  }
}

###############################################################################
# Subnets
###############################################################################
resource "aws_subnet" "PublicSubnetA" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.public_cidr_a
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "PublicSubnetA"
  }
}

resource "aws_subnet" "PublicSubnetB" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.public_cidr_b
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "PublicSubnetB"
  }
}

resource "aws_subnet" "PublicSubnetC" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.public_cidr_c
  availability_zone       = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "PublicSubnetC"
  }
}

resource "aws_subnet" "PrivateSubnetA" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.private_cidr_a
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "PrivateSubnetA"
  }
}

resource "aws_subnet" "PrivateSubnetB" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.private_cidr_b
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "PrivateSubnetB"
  }
}

resource "aws_subnet" "PrivateSubnetC" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.private_cidr_c
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = {
    Name = "PrivateSubnetC"
  }
}

###############################################################################
# IGW
###############################################################################
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "TestIGW"
  }
}

###############################################################################
# Route Table
###############################################################################
resource "aws_route_table" "RouteTablePublic" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "RouteTablePublic"
  }
}

resource "aws_route_table" "RouteTablePrivateA" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "RouteTablePrivateA"
  }
}

resource "aws_route_table" "RouteTablePrivateB" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "RouteTablePrivateB"
  }
}

resource "aws_route_table" "RouteTablePrivateC" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "RouteTablePrivateC"
  }
}

###############################################################################
# EIP
###############################################################################
resource "aws_eip" "EIPNatA" {
  vpc = true
  tags = {
    Name = "EIPNatA"
  }
}

resource "aws_eip" "EIPNatB" {
  vpc = true
  tags = {
    Name = "EIPNatB"
  }
}

resource "aws_eip" "EIPNatC" {
  vpc = true
  tags = {
    Name = "EIPNatC"
  }
}

###############################################################################
# NATGW
###############################################################################
resource "aws_nat_gateway" "NATGatewaySubnetA" {
  allocation_id = aws_eip.EIPNatA.id
  subnet_id     = aws_subnet.PublicSubnetA.id
  tags = {
    Name = "NATGatewaySubnetA"
  }
}

resource "aws_nat_gateway" "NATGatewaySubnetB" {
  allocation_id = aws_eip.EIPNatB.id
  subnet_id     = aws_subnet.PublicSubnetB.id
  tags = {
    Name = "NATGatewaySubnetB"
  }
}

resource "aws_nat_gateway" "NATGatewaySubnetC" {
  allocation_id = aws_eip.EIPNatC.id
  subnet_id     = aws_subnet.PublicSubnetC.id
  tags = {
    Name = "NATGatewaySubnetC"
  }
}

###############################################################################
# Route
###############################################################################
resource "aws_route" "RouteIGW" {
  route_table_id         = aws_route_table.RouteTablePublic.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
}

resource "aws_route" "RouteNatGatewayA" {
  route_table_id         = aws_route_table.RouteTablePrivateA.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NATGatewaySubnetA.id
}

resource "aws_route" "RouteNatGatewayB" {
  route_table_id         = aws_route_table.RouteTablePrivateB.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NATGatewaySubnetB.id
}

resource "aws_route" "RouteNatGatewayC" {
  route_table_id         = aws_route_table.RouteTablePrivateC.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NATGatewaySubnetC.id
}

###############################################################################
# Table Association
###############################################################################
resource "aws_route_table_association" "RouteAssocPublicA" {
  subnet_id      = aws_subnet.PublicSubnetA.id
  route_table_id = aws_route_table.RouteTablePublic.id
}

resource "aws_route_table_association" "RouteAssocPublicB" {
  subnet_id      = aws_subnet.PublicSubnetB.id
  route_table_id = aws_route_table.RouteTablePublic.id
}

resource "aws_route_table_association" "RouteAssocPublicC" {
  subnet_id      = aws_subnet.PublicSubnetC.id
  route_table_id = aws_route_table.RouteTablePublic.id
}

resource "aws_route_table_association" "RouteAssocPrivateA" {
  subnet_id      = aws_subnet.PrivateSubnetA.id
  route_table_id = aws_route_table.RouteTablePrivateA.id
}

resource "aws_route_table_association" "RouteAssocPrivateB" {
  subnet_id      = aws_subnet.PrivateSubnetB.id
  route_table_id = aws_route_table.RouteTablePrivateB.id
}

resource "aws_route_table_association" "RouteAssocPrivateC" {
  subnet_id      = aws_subnet.PrivateSubnetC.id
  route_table_id = aws_route_table.RouteTablePrivateC.id
}
