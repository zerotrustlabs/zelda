
# https://github.com/tal-rofe/url-shortener/blob/main/terraform/modules/ssl-static-app/cloudfront.tf

# https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest
# https://github.com/terraform-aws-modules/terraform-aws-s3-bucket/tree/master/modules

resource "aws_cloudfront_distribution" "spa_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.my_static_website.bucket}.s3.amazonaws.com"
    origin_id   = "S3-zelda-Origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = "S3-zelda-Origin"
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


resource "aws_s3_bucket_policy" "zelda_cf_bucket_policy" {
  bucket = aws_s3_bucket.my_static_website.id

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
        Action = "s3:GetObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.my_static_website.id}/*"
      }
    ]
  })
}


data "archive_file" "edge_lambda_function" {
  type             = "zip"
  source_file      = "${path.module}/scripts/edge_lambda.py"
  output_file_mode = "0666"
  output_path      = "${path.module}/files/edge_lambda.zip"
}

resource "aws_lambda_function" "edge_lambda" {
  filename         = data.archive_file.edge_lambda_function.output_path
  function_name    = "edge_lambda"
  role        = aws_iam_role.lambda_logging_role.arn
  handler          = "lambda_function.handler"
  runtime          = "python3.8"
  publish          = true

  source_code_hash = filebase64sha256(data.archive_file.edge_lambda_function.output_path)
  depends_on = [data.archive_file.edge_lambda_function]
}

# resource "aws_iam_role" "lambda_exec_role" {
#   name = "lambda_exec_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy" "lambda_exec_policy" {
#   name = "lambda_exec_policy"
#   role = aws_iam_role.lambda_exec_role.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ],
#         Effect = "Allow",
#         Resource = "arn:aws:logs:*:*:*"
#       }
#     ]
#   })
# }

# Redirect unauthenticated users to a sign-in page using lambda edge attached to cloudfront also redirects unauth access to index page
#  https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/lambda-examples.html
# def handler(event, context):
#     request = event['Records'][0]['cf']['request']
#     uri = request['uri']

#     if not uri.endswith(('.html', '.js', '.css', '.png', '.jpg')):
#         request['uri'] = '/index.html'

#     return request


