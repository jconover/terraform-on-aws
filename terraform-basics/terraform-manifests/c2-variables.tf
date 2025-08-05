# Input Variables

# AWS Region
variable "aws_region" {
  type        = string
  description = "Region where AWS resources will be created"
  default     = "us-east-1"
}

# AWS EC2 Instance Type
variable "aws_instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

# AWS EC2 Key Pair
variable "aws_key_pair" {
  type        = string
  description = "EC2 key pair name"
  default     = "terraform"
}