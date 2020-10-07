resource "aws_vpc" "Wireless-vpc" {
  cidr_block           = var.CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC_ej_Terraform"

  }
}

resource "aws_subnet" "Wireless-private-subnet" {
  vpc_id                  = aws_vpc.Wireless-vpc.id
  cidr_block              = var.subnet
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Wireless-subnet-terraform"
  }
}

resource "aws_internet_gateway" "Wireless-gateway" {
  vpc_id = aws_vpc.Wireless-vpc.id
  tags = {
    Name = "Wireless-gateway"
  }
}

resource "aws_default_route_table" "Wireless-route" {
  default_route_table_id = aws_vpc.Wireless-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Wireless-gateway.id
  }
  tags = {
    Name = "Wireless-default-route"
  }
}