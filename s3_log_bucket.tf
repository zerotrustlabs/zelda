resource "aws_s3_bucket_public_access_block" "log_bucket" {
  #   count  = local.create_bucket && var.attach_public_policy ? 1 : 0
  bucket = aws_s3_bucket.log_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "this" {
  #   count = local.create_bucket && length(keys(var.logging)) > 0 ? 1 : 0

  bucket = aws_s3_bucket.this.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}
resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket     = aws_s3_bucket.log_bucket.id
  acl        = "log-delivery-write"
  depends_on = [aws_s3_bucket_ownership_controls.application_logs]
}

resource "aws_s3_bucket_ownership_controls" "application_logs" {
  bucket = aws_s3_bucket.log_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}
resource "aws_s3_bucket" "log_bucket" {
  bucket        = "zelda-tf-log-bucket-${random_string.suffix.id}"
  force_destroy = var.website_bucket_force_destroy
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_log_bucket_server_side_encryption_configuration" {
  bucket = aws_s3_bucket.log_bucket.id

  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# waflogbucket
# aws-waf-logs-example-bucket
resource "aws_s3_bucket" "aws-waf-logs-bucket" {
  bucket        = "zelda-waf-tf-log-bucket-${random_string.suffix.id}"
  force_destroy = var.website_bucket_force_destroy
}

resource "aws_s3_bucket_ownership_controls" "waf_logs" {
  bucket = aws_s3_bucket.aws-waf-logs-bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}
resource "aws_s3_bucket_acl" "waf_log_bucket_acl" {
  bucket     =  aws_s3_bucket.aws-waf-logs-bucket.id
  acl        = "log-delivery-write"
  depends_on = [aws_s3_bucket_ownership_controls.waf_logs]
}
resource "aws_s3_bucket_public_access_block" "waf_log_bucket" {
  #   count  = local.create_bucket && var.attach_public_policy ? 1 : 0
  bucket = aws_s3_bucket.aws-waf-logs-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "waf_s3_log_bucket_server_side_encryption_configuration" {
  bucket = aws_s3_bucket.aws-waf-logs-bucket.id

  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}