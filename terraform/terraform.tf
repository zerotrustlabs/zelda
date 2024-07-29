terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.21.0"
    }
  }

  required_version = "~> 1.2"
}
provider "aws" {
  region = "us-east-1"
}
# provider "template"{
#   source = "hashicorp/template"
# }