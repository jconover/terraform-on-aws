# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

# Data source for latest Ubuntu 24.04 LTS AMI
data "aws_ami" "ubuntu_24_04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# VPC
resource "aws_vpc" "ubuntu_main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-ubuntu-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "ubuntu_main" {
  vpc_id = aws_vpc.ubuntu_main.id

  tags = {
    Name = "${var.project_name}-ubuntu-igw"
  }
}

# Public Subnet
resource "aws_subnet" "ubuntu_public" {
  vpc_id                  = aws_vpc.ubuntu_main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-ubuntu-public-subnet"
  }
}

# Route Table
resource "aws_route_table" "ubuntu_public" {
  vpc_id = aws_vpc.ubuntu_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ubuntu_main.id
  }

  tags = {
    Name = "${var.project_name}-ubuntu-public-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "ubuntu_public" {
  subnet_id      = aws_subnet.ubuntu_public.id
  route_table_id = aws_route_table.ubuntu_public.id
}

# Security Group - SSH only
resource "aws_security_group" "ubuntu_ec2_sg" {
  name_prefix = "${var.project_name}-ubuntu-ec2-sg"
  vpc_id      = aws_vpc.ubuntu_main.id

  # SSH access only
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ubuntu-ec2-sg"
  }
}

# Key Pair
resource "aws_key_pair" "ubuntu_deployer" {
  key_name   = "${var.project_name}-ubuntu-key"
  public_key = var.ssh_public_key
}

# EC2 Instance - Ubuntu 24.04 LTS
resource "aws_instance" "ubuntu_web" {
  ami                    = data.aws_ami.ubuntu_24_04.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.ubuntu_deployer.key_name
  vpc_security_group_ids = [aws_security_group.ubuntu_ec2_sg.id]
  subnet_id              = aws_subnet.ubuntu_public.id

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get upgrade -y
              echo "Ubuntu 24.04 LTS instance is ready!"
              EOF

  tags = {
    Name = "${var.project_name}-ubuntu-ec2"
  }
}
