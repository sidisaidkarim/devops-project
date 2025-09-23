terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

resource "aws_vpc" "VPC-A" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC-A"
  }
}

resource "aws_subnet" "subnet-app" {
  vpc_id = aws_vpc.VPC-A.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-3a"
  tags = {
    Name = "subnet-app"
  }
}

resource "aws_subnet" "subnet-web" {
  vpc_id = aws_vpc.VPC-A.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-3b"
  tags = {
    Name = "subnet-web"
  }
}

resource "aws_subnet" "subnet-db" {
  vpc_id = aws_vpc.VPC-A.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-3c"
  tags = {
    Name = "subnet-db"
  }
}

resource "aws_internet_gateway" "vpc-a-igw" {
  vpc_id = aws_vpc.VPC-A.id
  tags = {
    Name = "vpc-a-igw"
  }
}

resource "aws_route_table" "vpc-a-rt-table" {
  vpc_id = aws_vpc.VPC-A.id
  tags = {
    Name= "vpc-a-rt-tabl"
  }
}

resource "aws_route_table_association" "vpc-a-rt-table-asso" {
  subnet_id = aws_subnet.subnet-app.id
  route_table_id = aws_route_table.vpc-a-rt-table.id
}
