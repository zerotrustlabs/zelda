
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
  default     = "603825719481"
}

# Input variable definitions
variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "us-east-1"
}

variable "project_prefix" {
  description = "Project prefix"
  type        = string
  default     = "zelda-online-prod"
}

variable "create_bucket" {
  description = "Controls if S3 bucket should be created"
  type        = bool
  default     = true
}

variable "website_root" {
  type        = string
  description = "Path to the root of website content"
  default     = "../content"
}

variable "file_types" {
  type = map(string)
  default = {
    ".txt"    = "text/plain; charset=utf-8"
    ".html"   = "text/html; charset=utf-8"
    ".htm"    = "text/html; charset=utf-8"
    ".xhtml"  = "application/xhtml+xml"
    ".css"    = "text/css; charset=utf-8"
    ".js"     = "application/javascript"
    ".xml"    = "application/xml"
    ".json"   = "application/json"
    ".jsonld" = "application/ld+json"
    ".gif"    = "image/gif"
    ".jpeg"   = "image/jpeg"
    ".jpg"    = "image/jpeg"
    ".png"    = "image/png"
    ".svg"    = "image/svg+xml"
    ".webp"   = "image/webp"
    ".weba"   = "audio/webm"
    ".webm"   = "video/webm"
    ".3gp"    = "video/3gpp"
    ".3g2"    = "video/3gpp2"
    ".pdf"    = "application/pdf"
    ".swf"    = "application/x-shockwave-flash"
    ".atom"   = "application/atom+xml"
    ".rss"    = "application/rss+xml"
    ".ico"    = "image/vnd.microsoft.icon"
    ".jar"    = "application/java-archive"
    ".ttf"    = "font/ttf"
    ".otf"    = "font/otf"
    ".eot"    = "application/vnd.ms-fontobject"
    ".woff"   = "font/woff"
    ".woff2"  = "font/woff2"
  }
  description = "Map from file suffixes, which must begin with a period and contain no periods, to the corresponding Content-Type values."
}

variable "default_file_type" {
  type        = string
  default     = "application/octet-stream"
  description = "The Content-Type value to use for any files that don't match one of the suffixes given in file_types."
}
variable "website_bucket_force_destroy" {
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}