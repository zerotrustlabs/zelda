
resource "aws_api_gateway_rest_api" "react_app_api" {
  name        = "react_app_api"
  description = "API for React eCommerce app"
}

resource "aws_api_gateway_resource" "products" {
  rest_api_id = aws_api_gateway_rest_api.react_app_api.id
  parent_id   = aws_api_gateway_rest_api.react_app_api.root_resource_id
  path_part   = "products"
}

resource "aws_api_gateway_method" "get_products" {
  rest_api_id   = aws_api_gateway_rest_api.react_app_api.id
  resource_id   = aws_api_gateway_resource.products.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "create_product" {
  rest_api_id   = aws_api_gateway_rest_api.react_app_api.id
  resource_id   = aws_api_gateway_resource.products.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

# resource "aws_api_gateway_method" "get_product" {
#   rest_api_id   = aws_api_gateway_rest_api.react_app_api.id
#   resource_id   = aws_api_gateway_resource.products.id
#   http_method   = "GET"
#   authorization = "COGNITO_USER_POOLS"
#   authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
# }

resource "aws_api_gateway_method" "update_product" {
  rest_api_id   = aws_api_gateway_rest_api.react_app_api.id
  resource_id   = aws_api_gateway_resource.products.id
  http_method   = "PUT"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "get_products_integration" {
  rest_api_id = aws_api_gateway_rest_api.react_app_api.id
  resource_id = aws_api_gateway_resource.products.id
  http_method = aws_api_gateway_method.get_products.http_method
  type        = "AWS_PROXY"

  integration_http_method = "POST"
  uri                     = aws_lambda_function.get_products.invoke_arn
}

resource "aws_api_gateway_integration" "create_product_integration" {
  rest_api_id = aws_api_gateway_rest_api.react_app_api.id
  resource_id = aws_api_gateway_resource.products.id
  http_method = aws_api_gateway_method.create_product.http_method
  type        = "AWS_PROXY"

  integration_http_method = "POST"
  uri                     = aws_lambda_function.add_products.invoke_arn
}

# resource "aws_api_gateway_integration" "get_product_integration" {
#   rest_api_id = aws_api_gateway_rest_api.react_app_api.id
#   resource_id = aws_api_gateway_resource.products.id
#   http_method = aws_api_gateway_method.get_product.http_method
#   type        = "AWS_PROXY"

#   integration_http_method = "POST"
#   uri                     = aws_lambda_function.get_products.invoke_arn
# }

resource "aws_api_gateway_integration" "update_product_integration" {
  rest_api_id = aws_api_gateway_rest_api.react_app_api.id
  resource_id = aws_api_gateway_resource.products.id
  http_method = aws_api_gateway_method.update_product.http_method
  type        = "AWS_PROXY"

  integration_http_method = "POST"
  uri                     = aws_lambda_function.update_products.invoke_arn
}

resource "aws_api_gateway_deployment" "react_app_deployment" {
  depends_on = [
    aws_api_gateway_integration.get_products_integration,
    aws_api_gateway_integration.create_product_integration,
    # aws_api_gateway_integration.get_product_integration,
    aws_api_gateway_integration.update_product_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.react_app_api.id
  stage_name  = "prod"
}

resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  rest_api_id = aws_api_gateway_rest_api.react_app_api.id
  name        = "cognito_authorizer"
  type        = "COGNITO_USER_POOLS"
  provider_arns = [
    aws_cognito_user_pool.user_pool.arn
  ]
  
}





resource "aws_lambda_permission" "apigw_lambda_addProducts" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.add_products.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.account_id}:${aws_api_gateway_rest_api.react_app_api.id}/*/${aws_api_gateway_method.create_product.http_method}${aws_api_gateway_resource.products.path}"
}

# resource "aws_lambda_permission" "apigw_lambda_confirm_order" {
#   statement_id  = "AllowExecutionFromAPIGateway"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.confirm_order_lambda.function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.OrdersAPI.id}/*/${aws_api_gateway_method.ConfirmOrderMethod.http_method}${aws_api_gateway_resource.ConfirmOrderResource.path}"
# } 

# API Gateway Authorizer

# resource "aws_api_gateway_authorizer" "api-auth" {
#   name          = "CognitoUserPoolAuthorizer"
#   type          = "COGNITO_USER_POOLS"
#   rest_api_id   = aws_api_gateway_rest_api.OrdersAPI.id
#   provider_arns = ["arn:aws:cognito-idp:${var.region}:${var.account_id}:userpool/${aws_cognito_user_pool.orders.id}"]
# } 