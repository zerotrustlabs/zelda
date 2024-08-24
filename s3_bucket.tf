resource "aws_s3_bucket" "zelda_static_website" {
  bucket        = "${var.project_prefix}-ztls"
  force_destroy = var.website_bucket_force_destroy
  tags = (merge(
    tomap({ "Application" = "${var.project_prefix}" }),
    tomap({ "Managed" = "Terraform" })
  ))
}

resource "aws_s3_bucket_versioning" "zelda_static_versioning" {
  bucket = aws_s3_bucket.zelda_static_website.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.zelda_static_website.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }

}


resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket     = aws_s3_bucket.zelda_static_website.id
  acl        = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_object" "object_www" {
  depends_on   = [aws_s3_bucket.zelda_static_website]
  for_each     = local.website_files
  bucket       = aws_s3_bucket.zelda_static_website.id
  key          = each.key
  source       = "${var.website_root}/${each.key}"
  source_hash  = local.file_hashes[each.key]
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), null)
  acl          = "private"
}

resource "aws_s3_bucket_policy" "s3_bucket" {
  bucket = aws_s3_bucket.zelda_static_website.id
  policy = data.aws_iam_policy_document.s3_access.json
}


resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.zelda_static_website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.example]
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.zelda_static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}