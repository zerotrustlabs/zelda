resource "aws_s3_bucket" "this" {
#   count               = local.create_bucket ? 1 : 0
  bucket              = var.bucket
  bucket_prefix       = var.bucket_prefix
  force_destroy       = var.website_bucket_force_destroy
  object_lock_enabled = var.object_lock_enabled
  tags = (merge(
    tomap({ "Application" = "${var.project_prefix}" }),
    tomap({ "Managed" = "Terraform" })
  ))
}
resource "aws_s3_bucket" "log_bucket" {
  bucket = "zelda-tf-log-bucket"
  force_destroy       = var.website_bucket_force_destroy
}
resource "aws_s3_bucket_versioning" "this" {
#   count  = local.create_bucket && length(keys(var.website)) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_website_configuration" "s3_bucket" {
#   count  = local.create_bucket && length(keys(var.website)) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }

}


resource "aws_s3_bucket_acl" "s3_bucket" {
#   count      = local.create_bucket && local.create_bucket_acl ? 1 : 0
  bucket     = aws_s3_bucket.this.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_object" "object_www" {
  # count = local.create_bucket && var.control_object_ownership ? 1 : 0
  depends_on   = [aws_s3_bucket.this]
  for_each     = local.website_files
  bucket       = aws_s3_bucket.this.id
  key          = each.key
  source       = "${var.website_root}/${each.key}"
  source_hash  = local.file_hashes[each.key]
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), null)
  acl          = "private"
}

resource "aws_s3_bucket_policy" "s3_bucket" {
#   count  = local.create_bucket && var.attach_public_policy ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.s3_access.json
}


resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
#   count  = local.create_bucket && var.control_object_ownership ? 1 : 0
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.this]
}

resource "aws_s3_bucket_public_access_block" "this" {
#   count  = local.create_bucket && var.attach_public_policy ? 1 : 0
  bucket = aws_s3_bucket.this.id

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
  bucket = aws_s3_bucket.log_bucket.id
  acl    = "log-delivery-write"
  depends_on = [aws_s3_bucket_ownership_controls.application_logs]
}

resource "aws_s3_bucket_ownership_controls" "application_logs" {
  bucket = aws_s3_bucket.log_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}
resource "aws_s3_bucket_object_lock_configuration" "this" {
#   count = local.create_bucket && var.object_lock_enabled && try(var.object_lock_configuration.rule.default_retention, null) != null ? 1 : 0

  bucket                = aws_s3_bucket.this.id
  expected_bucket_owner = var.expected_bucket_owner
#   token                 = try(var.object_lock_configuration.token, null)
  rule {
    default_retention {
     mode = "COMPLIANCE"
      days = 5
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_server_side_encryption_configuration" {
  bucket = aws_s3_bucket.this.id

  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "this" {
  bucket = aws_s3_bucket.this.id  

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }  
}