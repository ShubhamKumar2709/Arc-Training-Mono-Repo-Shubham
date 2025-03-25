
# VPC
resource "aws_vpc" "stage-vpc" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-stage"
  }
}

# Public Subnets
resource "aws_subnet" "publicsubnet" {
  count                   = length(var.az)
  vpc_id                  = aws_vpc.stage-vpc.id
  cidr_block              = element(var.publicsubnet, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.az, count.index)

  tags = {
    Name = "stage-public-${count.index + 1}"
  }
}

# Private Subnets
resource "aws_subnet" "privatesubnet" {
  count             = length(var.az)
  vpc_id            = aws_vpc.stage-vpc.id
  cidr_block        = element(var.privatesubnet, count.index)
  availability_zone = element(var.az, count.index)

  tags = {
    Name = "stage-private-${count.index + 1}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  count  = var.create_internet_gateway ? 1 : 0
  vpc_id = aws_vpc.stage-vpc.id

  tags = {
    Name = "stage-igw"
  }
}

resource "aws_eip" "nat_eip" {
  count = var.create_nat_gateway ? var.nat_gateway_count : 0
}

resource "aws_nat_gateway" "nat_gw" {
  count         = var.create_nat_gateway ? var.nat_gateway_count : 0
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.publicsubnet[count.index].id # Uses first N public subnets

  tags = {
    Name = "stage-nat-gw-${count.index + 1}"
  }
}

# Public Route Table
resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.stage-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }

  tags = {
    Name = "publicroute"
  }
}

# Private Route Table
resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.stage-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw[0].id

  }

  tags = {
    Name = "privateroute"
  }
}

resource "aws_route_table_association" "public-association-a" {
  subnet_id      = aws_subnet.publicsubnet[0].id
  route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "public-association-b" {
  subnet_id      = aws_subnet.publicsubnet[1].id
  route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "private-association-a" {
  subnet_id      = aws_subnet.privatesubnet[0].id
  route_table_id = aws_route_table.privateroute.id
}

resource "aws_route_table_association" "private-association-b" {
  subnet_id      = aws_subnet.privatesubnet[1].id
  route_table_id = aws_route_table.privateroute.id
}
