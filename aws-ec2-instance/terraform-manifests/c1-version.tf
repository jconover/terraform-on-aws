# Terraform Block
terraform {
    required_version = ">= 1.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
}