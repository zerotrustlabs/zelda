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