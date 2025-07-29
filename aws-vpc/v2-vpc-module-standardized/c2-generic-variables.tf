# Input Variables

# AWS Region

variable "aws_region" {
  type        = string
  description = "Region where AWS resources will be created"
  default     = "us-east-2"
}

# Environment Variables

variable "environment" {
  type        = string
  description = "The environment for the resources"
  default     = "dev"
}

# Business Division Variables

variable "business_division" {
  type        = string
  description = "The business division for the resources"
  default     = "SAP"
}