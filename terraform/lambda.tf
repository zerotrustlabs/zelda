# resource "aws_lambda_function" "post_auth_lambda" {
#   function_name = "post-authentication-logger"
#   role          = aws_iam_role.lambda_logging_role.arn
#   handler       = "post_auth.handler"
#   runtime       = "python3.8"

#   filename         = "lambda_function.zip"
#   source_code_hash = filebase64sha256("lambda_function.zip")

#   environment {
#     variables = {
#       LOG_LEVEL = "INFO"
#     }
#   }
#   depends_on = [null_resource.zip_lambda]
# }
resource "random_id" "server" {
  byte_length = 8
}

data "archive_file" "lambda_my_function" {
  type             = "zip"
  source_file      = "post_auth.py"
  output_file_mode = "0666"
  output_path      = "${path.module}/files/post_auth.zip"
}

resource "aws_lambda_function" "post_auth_lambda" {
  function_name = "post_auth_lambda_${random_id.server.hex}"
  #checkov:skip=CKV_AWS_117: "Ensure that AWS Lambda function is configured inside a VPC"
  #checkov:skip=CKV_AWS_116: "Ensure that AWS Lambda function is configured for a Dead Letter Queue(DLQ)"
  role        = aws_iam_role.lambda_logging_role.arn
  description = "This lambda function verifies the main project's dependencies, requirements and implement auxiliary functions"
  handler     = "post_auth.lambda_handler"
  filename    = data.archive_file.lambda_my_function.output_path
  # source_code_hash = filebase64sha256("${path.module}/files/post_auth.zip")
  source_code_hash               = filebase64sha256(data.archive_file.lambda_my_function.output_path)
  runtime                        = "python3.8"
  timeout                        = 300
  memory_size                    = 128
  reserved_concurrent_executions = 1
  tracing_config {
    mode = "Active"
  }
  depends_on = [data.archive_file.lambda_my_function]
}


# Products Lambda

# Lambda Functions
# resource "aws_lambda_function" "get_products" {
#   filename         = "lambda/getProducts.zip"
#   function_name    = "get_products"
#   role             = aws_iam_role.lambda_execution.arn
#   handler          = "index.handler"
#   runtime          = "nodejs14.x"
# }

# resource "aws_lambda_function" "add_product" {
#   filename         = "lambda/addProduct.zip"
#   function_name    = "add_product"
#   role             = aws_iam_role.lambda_execution.arn
#   handler          = "index.handler"
#   runtime          = "nodejs14.x"
# }

# resource "aws_lambda_function" "update_product" {
#   filename         = "lambda/updateProduct.zip"
#   function_name    = "update_product"
#   role             = aws_iam_role.lambda_execution.arn
#   handler          = "index.handler"
#   runtime          = "nodejs14.x"
# }

# resource "aws_lambda_function" "delete_product" {
#   filename         = "lambda/deleteProduct.zip"
#   function_name    = "delete_product"
#   role             = aws_iam_role.lambda_execution.arn
#   handler          = "index.handler"
#   runtime          = "nodejs14.x"
# }