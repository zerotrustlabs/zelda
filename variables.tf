
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



variable "aws_access_key_id" {
  description = "AWS AWS_ACCESS_KEY_ID."
  type        = string
}

variable "aws_secret_access_key" {
  description = "AWS AWS_SECRET_ACCESS_KEY."
  type        = string
}

variable "aws_session_token" {
  description = "AWS AWS_SECRET_ACCESS_KEY."
  type        = string
}

variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
}