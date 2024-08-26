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