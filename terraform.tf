terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.21.0"
      aws_region = "eu-west-1"
    }
  }

  required_version = "~> 1.2"
}