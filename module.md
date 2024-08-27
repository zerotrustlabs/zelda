module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.8.2"

  bucket_prefix = "${var.app_name}-${var.env}-"

  force_destroy = true

  website = {
    index_document = "index.html"
    error_document = "index.html"
  }

}

data "aws_iam_policy_document" "read_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_bucket.s3_bucket_arn}/*"]
  }
}

# Need for avoid `Error putting S3 policy: AccessDenied: Access Denied`
resource "time_sleep" "wait_2_seconds" {
  depends_on      = [module.s3_bucket.s3_bucket_website_domain]
  create_duration = "2s"
}

resource "aws_s3_bucket_policy" "read_access" {
  bucket = module.s3_bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.read_access.json

  depends_on = [
    time_sleep.wait_2_seconds
  ]
}