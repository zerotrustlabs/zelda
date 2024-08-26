resource "aws_cognito_user_pool" "user_pool" {
  name = "zerotrust_users"

  username_attributes      = ["email"]
  username_configuration {
    case_sensitive = true
  }
  auto_verified_attributes = ["email"]
  password_policy {
    temporary_password_validity_days = 7
    minimum_length                   = 6
    require_uppercase                = false
    require_symbols                  = false
    require_numbers                  = false
  }
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Account Confirmation"
    email_message        = "Your confirmation code is {####}"
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }

    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  schema {
    name                     = "terraform"
    attribute_data_type      = "Boolean"
    mutable                  = true
    required                 = false
    developer_only_attribute = false
  }
email_configuration {
  email_sending_account = "COGNITO_DEFAULT"
}
  schema {
    name                     = "foo"
    attribute_data_type      = "String"
    mutable                  = false
    required                 = false
    developer_only_attribute = false
    string_attribute_constraints {}
  }

    /** Required Standard Attributes*/
    schema {
      attribute_data_type = "String"
      mutable = true
      name = "email"
      required = true
      string_attribute_constraints {
        min_length = 1
        max_length = 2048
      }
    }

    schema {
      attribute_data_type = "String"
      mutable = true
      name = "given_name"
      required = false
      string_attribute_constraints {
        min_length = 1
        max_length = 2048
      }
    }

    schema {
      attribute_data_type = "String"
      mutable = true
      name = "family_name"
      required = false
      string_attribute_constraints {
        min_length = 1
        max_length = 2048
      }
    }

    /** Custom Attributes */
    schema {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "PersonalInfo"
      required                 = false
      string_attribute_constraints {
        min_length = 1
        max_length = 2048
      }
    }

    schema {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "Role"
      required                 = false
      string_attribute_constraints {
        min_length = 1
        max_length = 2048
      }
    }  
  # lambda_config {
  #   post_authentication = aws_lambda_function.post_auth_lambda.arn
  # }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name = "zerotrust-cognito-client"

  user_pool_id                  = aws_cognito_user_pool.user_pool.id
  generate_secret               = false
  # Note that Generate client secret must be unchecked when creating a web app; the Amazon Cognito Identity SDK for JavaScript doesn’t support apps that have a client secret simply because the client secret could be easily viewed in your code.
  # https://aws.amazon.com/blogs/mobile/accessing-your-user-pools-using-the-amazon-cognito-identity-sdk-for-javascript/#:~:text=Note%20that%20Generate%20client%20secret,easily%20viewed%20in%20your%20code.
  refresh_token_validity        = 90
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_CUSTOM_AUTH",
  ]
  allowed_oauth_flows  = ["code", "implicit"]
  # allowed_oauth_flows  = ["code", "implicit", "client_credentials"]
  # allowed_oauth_flows  = ["client_credentials"]
  # allowed_oauth_scopes = ["email", "openid", "profile","aws.cognito.signin.user.admin"]
  allowed_oauth_scopes = aws_cognito_resource_server.resource.scope_identifiers
  callback_urls        = ["https://example.com/callback"]
  logout_urls          = ["https://example.com/logout"]
  supported_identity_providers         = ["COGNITO"]
  allowed_oauth_flows_user_pool_client = true
}

resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name               = "zerotrust_identity_pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id     = aws_cognito_user_pool_client.user_pool_client.id
    provider_name = aws_cognito_user_pool.user_pool.endpoint
  }
}

resource "aws_cognito_user_pool_domain" "cognito-domain" {
  domain       = "zelda-online"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

resource "aws_cognito_user_group" "admin" {
  name         = "admin"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  role_arn     = aws_iam_role.authenticated_role.arn
}


resource "aws_cognito_user" "ALLOW_USER_PASSWORD_AUTH" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  username     = "tonychue@gmail.com"

  attributes = {
    terraform      = true
    foo            = "bar"
    email          = "tonychue@gmail.com"
    email_verified = true
  }
}

resource "aws_cognito_user_in_group" "example" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  group_name   = aws_cognito_user_group.admin.name
  username     = aws_cognito_user.ALLOW_USER_PASSWORD_AUTH.username
}

resource "aws_cognito_resource_server" "resource" {
  identifier = "zelda-products"
  name       = "zelda-products"

  scope {
    scope_name        = "read-products"
    scope_description = "Retrieve Products"
  }

  user_pool_id = "${aws_cognito_user_pool.user_pool.id}"
}