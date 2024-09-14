resource "aws_cloudfront_distribution" "zeld_prod_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.this.bucket}.s3.amazonaws.com"
    origin_id   = "S3-zelda-Origin-prod"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = "S3-zelda-Origin-prod"
    viewer_protocol_policy = "redirect-to-https"

    # lambda_function_association {
    #   event_type   = "viewer-request"
    #   lambda_arn   = aws_lambda_function.edge_lambda.qualified_arn
    #   include_body = false
    # }

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for SPA"
  default_root_object = "index.html"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  web_acl_id = aws_wafv2_web_acl.zelda_cf_waf.arn
  # viewer_certificate {
  #   acm_certificate_arn = aws_acm_certificate.cert-my-aws-project-com.arn
  #   ssl_support_method = "sni-only"
  # }

  # depends_on = [
  #   aws_acm_certificate.cert-my-aws-project-com,
  # ]
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "OAI for accessing S3 bucket"
}


resource "aws_s3_bucket_policy" "zelda_prod_cf_bucket_policy" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        # Principal = "*",
        Principal = {
          # AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
          AWS = "${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"
        },
        Action   = "s3:GetObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.this.id}/*"
      }
    ]
  })
}
