data "aws_caller_identity" "self" {}
data "aws_iam_policy_document" "s3_access" {
    #   count   = local.create_bucket && local.attach_policy ? 1 : 0
    version = "2012-10-17"
    statement {
        sid    = "ObjectWriteAccess"
        effect = "Allow"
        actions = [
        "s3:PutObject*"
        ]
        resources = [
        "${aws_s3_bucket.this.arn}/*",
        ]
        principals {
        type = "AWS"
        #   identifiers = ["arn:aws:iam::603825719481:user/anthony"]
        identifiers = [aws_iam_role.authenticated_role.arn]
        }
        condition {
        test     = "StringEquals"
        variable = "s3:x-amz-acl"
        # Provider requires this value to be an array
        values = ["bucket-owner-full-control"]
        }
    }
    statement {
        sid    = "IPAllow"
        effect = "Deny"
        principals {
        type        = "*"
        identifiers = ["*"]
        }
        actions = ["s3:*"]
        resources = [
        aws_s3_bucket.this.arn,
        "${aws_s3_bucket.this.arn}/*",
        ]
        condition {
        test     = "StringEquals"
        variable = "aws:SecureTransport"
        values   = ["false"]
        }
    }
}

