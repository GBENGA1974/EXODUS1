# Main VPC

resource "aws_vpc" "EXODUS-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "EXODUS-VPC"
  }
}


# PUBLIC SUBNET1

resource "aws_subnet" "EXODUS-PUB1-SUB1" {
  vpc_id     = aws_vpc.EXODUS-VPC.id
  cidr_block = "10.0.11.0/24"

  tags = {
    Name = "EXODUS-PUB1-SUB1"
  }
}

# PUBLIC SUBNET2

resource "aws_subnet" "EXODUS-PUB2-SUB2" {
  vpc_id     = aws_vpc.EXODUS-VPC.id
  cidr_block = "10.0.12.0/24"

  tags = {
    Name = "EXODUS-PUB2-SUB2"
  }
}

# PRIVATE SUBNET1

resource "aws_subnet" "EXODUS-PRIV1-SUB3" {
  vpc_id     = aws_vpc.EXODUS-VPC.id
  cidr_block = "10.0.13.0/24"

  tags = {
    Name = "EXODUS-PRIV1-SUB3"
  }
}

# PRIVATE SUBNET2

resource "aws_subnet" "EXODUS-PRIV2-SUB4" {
  vpc_id     = aws_vpc.EXODUS-VPC.id
  cidr_block = "10.0.14.0/24"

  tags = {
    Name = "EXODUS-PRIV2-SUB4"
  }
}

# PRIVATE SUBNET3

resource "aws_subnet" "EXODUS-PRIV3-SUB5" {
  vpc_id     = aws_vpc.EXODUS-VPC.id
  cidr_block = "10.0.15.0/24"

  tags = {
    Name = "EXODUS-PRIV3-SUB5"
  }
}

# PUBLIC ROUTE TABLE

resource "aws_route_table" "EXODUS-PUBLIC-RT" {
  vpc_id = aws_vpc.EXODUS-VPC.id

  tags = {
    Name = "EXODUS-PUBLIC-RT"
  }
}

# PRIVATE ROUTE TABLE

resource "aws_route_table" "EXODUS-PRIVATE-RT" {
  vpc_id = aws_vpc.EXODUS-VPC.id

  tags = {
    Name = "EXODUS-PRIVATE-RT"
  }
}

# PUBLIC SUBNET1 ASSOCIATION WITH PUBLIC ROUTE TABLE

resource "aws_route_table_association" "EXODUS-PUBSUB1-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.EXODUS-PUB1-SUB1.id
  route_table_id = aws_route_table.EXODUS-PUBLIC-RT.id
}

# PUBLIC SUBNET2 ASSOCIATION WITH PUBLIC ROUTE TABLE

resource "aws_route_table_association" "EXODUS-PUBSUB2-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.EXODUS-PUB2-SUB2.id
  route_table_id = aws_route_table.EXODUS-PUBLIC-RT.id
}

# PRIVATE SUBNET1 ASSOCIATION WITH PRIVATE ROUTE TABLE

resource "aws_route_table_association" "EXODUS-PRIVSUB3-ASSOC-PRIV-RT" {
  subnet_id      = aws_subnet.EXODUS-PRIV1-SUB3.id
  route_table_id = aws_route_table.EXODUS-PRIVATE-RT.id
}

# PRIVATE SUBNET2 ASSOCIATION WITH PRIVATE ROUTE TABLE

resource "aws_route_table_association" "EXODUS-PRIVSUB4-ASSOC-PRIV-RT" {
  subnet_id      = aws_subnet.EXODUS-PRIV2-SUB4.id
  route_table_id = aws_route_table.EXODUS-PRIVATE-RT.id
}

# PRIVATE SUBNET3 ASSOCIATION WITH PRIVATE ROUTE TABLE

resource "aws_route_table_association" "EXODUS-PRIVSUB5-ASSOC-PRIV-RT" {
  subnet_id      = aws_subnet.EXODUS-PRIV3-SUB5.id
  route_table_id = aws_route_table.EXODUS-PRIVATE-RT.id
}


# INTERNET GATEWAY

resource "aws_internet_gateway" "EXODUS-igw" {
  vpc_id = aws_vpc.EXODUS-VPC.id

  tags = {
    Name = "EXODUS-igw"
  }
}


# IGW ASSOCIATION WITH ROUTE TABLE

resource "aws_route" "Assoc-public-RT" {
  route_table_id            = aws_route_table.EXODUS-PUBLIC-RT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.EXODUS-igw.id
}


