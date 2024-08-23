
variable "tfc_org_name" {
  description = "Name of the Terraform Cloud Organization"
  type        = string
  default     = "zerotrustlabs"
}

variable "tfc_network_workspace_name" {
  description = "Name of the network workspace"
  type        = string
  default     = "globallogicuki-aws-netwroking"
}

variable "account_id" {
  description = "AWS Account Id."
  type        = string
  default = "603825719481"
}

# Input variable definitions
variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default = "us-east-1"
}

variable "project_prefix" {
  description = "Project prefix"
  type        = string
  default = "zelda-online-prod"
}