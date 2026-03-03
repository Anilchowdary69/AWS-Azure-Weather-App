# Terraform configuration with remote state stored in S3
terraform {
  backend "s3" {
    bucket = "stock-market-terraform-state-6969"
    key    = "weatherapp/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    # AWS provider for S3, CloudFront, Route53
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    # Azure provider for Blob Storage
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# AWS provider configuration
provider "aws" {
  region = var.aws_region
}
# i need a separate AWS provider alias for us-east-1
# ACM certificates used with CloudFront must always be in us-east-1
# even if my other resources are in a different region
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
# Azure provider configuration
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}