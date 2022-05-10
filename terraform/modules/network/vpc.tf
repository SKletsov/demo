data "aws_availability_zones" "working" {}

locals {
  common_tags_vpc = {
    Name = var.name,
    "kubernetes.io/cluster/lab"="owned"
  }
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cid
  tags                 = local.common_tags_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "main_subnet_A_Private" {
  map_public_ip_on_launch = true 
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cid_priv
  availability_zone = data.aws_availability_zones.working.names[0]
  tags              = local.common_tags_vpc
}

resource "aws_subnet" "main_subnet_A_Public" {
  map_public_ip_on_launch = true 
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cid_pub
  availability_zone = data.aws_availability_zones.working.names[1]
  tags              = local.common_tags_vpc
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = local.common_tags_vpc
}

resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.gw]
  tags       = local.common_tags_vpc
}

// /* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.main_subnet_A_Public.id
  depends_on    = [aws_internet_gateway.gw]
  tags          = local.common_tags_vpc
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags   = local.common_tags_vpc
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags   = local.common_tags_vpc
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

/* Route table associations */
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.main_subnet_A_Public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.main_subnet_A_Private.id
  route_table_id = aws_route_table.private.id
}