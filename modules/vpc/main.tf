######## VPC ########

resource "aws_vpc" "wp-tf_Vpc" {
  cidr_block       = var.vpc_values.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "My_Vpc"
  }
}

######### local variable #########

locals {
  length = length(data.aws_availability_zones.available.names)
}

######### Availability zones #########

data "aws_availability_zones" "available" {
  state = "available"
}

######### VPC Subnets #########

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.wp-tf_Vpc.id
  count                   = length(var.vpc_values.public_subnet_cidr_block)
  cidr_block              = var.vpc_values.public_subnet_cidr_block[count.index]
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[count.index % local.length]


  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.wp-tf_Vpc.id
  count                   = length(var.vpc_values.private_subnet_cidr_block)
  cidr_block              = var.vpc_values.private_subnet_cidr_block[count.index]
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[count.index % local.length]

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

####### Internet Gateway ###########

resource "aws_internet_gateway" "wp-tf-ig" {
  vpc_id = aws_vpc.wp-tf_Vpc.id

  tags = {
    Name = "wp-tf-ig"
  }
}

####### Elastic_ip ###########

resource "aws_eip" "eip-ng" {
  vpc = true
}

####### NAT Gateway ###########

resource "aws_nat_gateway" "wp-tf-ng" {
  count         = length(var.vpc_values.private_subnet_cidr_block) == 0 ? 0 : 1
  allocation_id = aws_eip.eip-ng.id
  subnet_id     = aws_subnet.public-subnet[count.index].id
  tags = {
    Name = "wp-tf-ng"
  }
  depends_on = [aws_internet_gateway.wp-tf-ig]
}

####### Public Route Table ###########

resource "aws_route_table" "wp-tf-public-rt" {
  vpc_id = aws_vpc.wp-tf_Vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wp-tf-ig.id
  }

  tags = {
    Name = "wp-tf-public-rt"
  }
}

###### Private Route Table ###########

resource "aws_route_table" "wp-tf-private-rt" {
  count  = length(var.vpc_values.private_subnet_cidr_block) == 0 ? 0 : 1
  vpc_id = aws_vpc.wp-tf_Vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.wp-tf-ng[count.index].id
  }
  tags = {
    Name = "wp-tf-private-rt"
  }
}

####### Public Route Table Association ###########

resource "aws_route_table_association" "pub-rt-association" {
  count          = length(var.vpc_values.public_subnet_cidr_block)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.wp-tf-public-rt.id
}

####### Private Route Table Association ###########

resource "aws_route_table_association" "pri-rt-association" {
  count          = length(var.vpc_values.private_subnet_cidr_block)
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.wp-tf-private-rt[0].id
}