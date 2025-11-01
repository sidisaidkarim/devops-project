variable "vpc_a_name" {
  type = string
}

variable "vpc_a_cidr" {
  type = string
}

variable "vpc_b_name" {
  type = string
}

variable "vpc_b_cidr" {
  type = string
}

variable "subnet_az" {
  type = list(string)
}

resource "aws_vpc" "vpc-a" {
  cidr_block = var.vpc_a_cidr
  tags = {
    Name = var.vpc_a_name
  }
}

resource "aws_internet_gateway" "igw-a" {
  vpc_id = aws_vpc.vpc-a.id
  tags = {
    Name = "igw-${var.vpc_a_name}"
  }
}

resource "aws_vpc" "vpc-b" {
  cidr_block = var.vpc_b_cidr
  tags = {
    Name = var.vpc_b_name
  }
}

resource "aws_subnet" "subnetsA" {
  count = length(var.subnet_az) * 2
  vpc_id = aws_vpc.vpc-a.id
  cidr_block = cidrsubnet(var.vpc_a_cidr, 8, count.index)
  availability_zone = var.subnet_az[count.index % length(var.subnet_az)]
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-${var.subnet_az[count.index % length(var.subnet_az)]}"
  }
}

//route table for public subnets
resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.vpc-a.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-a.id
  }
}
//associate public subnets with route table
resource "aws_route_table_association" "rt-public" {
  count = length(var.subnet_az)
  route_table_id = aws_route_table.rt-public.id
  subnet_id = aws_subnet.subnetsA[count.index].id

}

resource "aws_subnet" "subnetsB" {
  count = length(var.subnet_az) - 1
  vpc_id = aws_vpc.vpc-b.id
  cidr_block = cidrsubnet(var.vpc_b_cidr, 8, count.index)
  availability_zone = var.subnet_az[count.index]
  tags = {
    Name = "subnet-${var.subnet_az[count.index]}"
  }
}

output "vpc_a_id" {
  value = aws_vpc.vpc-a.id
}

output "vpc_b_id" {
  value = aws_vpc.vpc-b.id
}

output "subnetsA" {
  value = aws_subnet.subnetsA
}

output "subnetsB" {
  value = aws_subnet.subnetsB
}
