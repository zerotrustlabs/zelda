terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.47"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4"
    }
  }

  required_version = "~> 1.2"
}
provider "aws" {
  region = "us-east-1"
}