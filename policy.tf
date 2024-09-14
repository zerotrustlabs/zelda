resource "aws_iam_role" "authenticated_role" {
  #   name = "Cognito_${aws_cognito_identity_pool.identity_pool.id}_auth_Role"
  name = local.authrole

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
        "StringEquals": {
            "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.identity_pool.id}"
        },
        "ForAnyValue:StringLike": {
            "cognito-identity.amazonaws.com:amr": "authenticated"
        }
        }
    }
    ]
}
EOF
}

resource "aws_iam_role" "unauthenticated_role" {
  # name                 = "zerotrustlabs_Cognito_unauth_Role"
  name                 = local.unauthrole
  max_session_duration = "3600"
  assume_role_policy   = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
        "StringEquals": {
            "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.identity_pool.id}"
        },
        "ForAnyValue:StringLike": {
            "cognito-identity.amazonaws.com:amr": "unauthenticated"
        }
        }
    }
    ]
}
EOF
}


# resource "aws_s3_bucket_policy" "this" {
#   count  = local.create_bucket && local.attach_policy ? 1 : 0
#   bucket = aws_s3_bucket.this[count.index].id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Id      = "MYBUCKETPOLICY"
#     Statement = [
#       {
#         Sid       = "IPAllow"
#         Effect    = "Deny"
#         Principal = "*"
#         Action    = "s3:*"
#         Resource = [
#           aws_s3_bucket.this[count.index].arn,
#           "${aws_s3_bucket.this[count.index].arn}/*",
#         ]
#         Condition = {
#           Bool = {
#             "aws:SecureTransport" = "false"
#           }
#         }
#       },
#     ]
#   })

#   # other required fields here
# }

resource "aws_iam_role_policy" "authenticated_policy" {
  name = "zerotrustlabs_Cognito_auth_Policy-prod"
  role = aws_iam_role.authenticated_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "${aws_s3_bucket.this.arn}",
        "${aws_s3_bucket.this.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "unauthenticated_policy" {
  name = "zerotrustlabs_Cognito_unauth_Policy_prod"
  role = aws_iam_role.unauthenticated_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*",
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "${aws_s3_bucket.this.arn}",
        "${aws_s3_bucket.this.arn}/*"
      ]
    }
  ]
}
EOF
}


resource "aws_cognito_identity_pool_roles_attachment" "roles_attachment" {
  identity_pool_id = aws_cognito_identity_pool.identity_pool.id
  roles = {
    "authenticated"   = aws_iam_role.authenticated_role.arn
    "unauthenticated" = aws_iam_role.unauthenticated_role.arn
  }
}

resource "aws_iam_role_policy" "s3_sse_policy" {
  name = "S3-server-side-encryption-policy"
  role = aws_iam_role.authenticated_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "PutObjectPolicy",
    "Statement" : [
      {
        "Sid" : "RestrictSSECObjectUploads",
        "Effect" : "Deny",
        "Action" : "s3:PutObject",
        "Resource" : "${aws_s3_bucket.this.arn}/*",
        "Condition" : {
          "StringNotEquals" : {
            "s3:x-amz-server-side-encryption" : "AES256"
          }
        }

      }
    ]
    }
  )
}


# Sage Maker Role
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-execution-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_exec_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "sagemaker:InvokeEndpoint",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
