provider "aws" {
  region = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = var.tags
  }
}

terraform {
  required_version = ">= 1.0"

  backend "s3" {

  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.62"
    }
  }
}