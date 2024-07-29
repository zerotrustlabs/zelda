resource "aws_s3_bucket" "my_static_website" {
  bucket = "zelda-online-m9wtv64y"
}


resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.my_static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}


resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket     = aws_s3_bucket.my_static_website.id
  acl        = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_object" "object_www" {
  depends_on   = [aws_s3_bucket.my_static_website]
  for_each     = local.website_files
  bucket       = aws_s3_bucket.my_static_website.id
  key          = each.key
  source       = "${var.website_root}/${each.key}"
  source_hash  = local.file_hashes[each.key]
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), null)
  acl          = "private"
}

resource "aws_s3_bucket_policy" "s3_bucket" {
  bucket = aws_s3_bucket.my_static_website.id

  policy = data.aws_iam_policy_document.s3_access.json
}


resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.my_static_website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.example]
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.my_static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# DynamoDB Table for Products
# resource "aws_dynamodb_table" "products" {
#   name           = "Products"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "productId"

#   attribute {
#     name = "productId"
#     type = "S"
#   }

#   attribute {
#     name = "category"
#     type = "S"
#   }

#   stream_enabled = true
#   stream_view_type = "NEW_AND_OLD_IMAGES"
# }



#  ----For deletion----------
# resource "aws_s3_bucket_acl" "s3_bucket_acl" {
#   bucket = aws_s3_bucket.bucket-one-two.id
#   acl    = "private"
#   depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
# }

# # Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
# resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
#   bucket = aws_s3_bucket.bucket-one-two.id
#   rule {
#     object_ownership = "ObjectWriter"
#   }
# }


# Cognito Identity Pool


# resource "aws_kms_key" "mykey" {
#   description             = "This key is used to encrypt bucket objects"
#   deletion_window_in_days = 10
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
#   bucket = aws_s3_bucket.my_static_website.id

#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = aws_kms_key.mykey.arn
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }