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


resource "terraform_data" "tf_data_resource_hello" {
  # Defines when the provisioner should be executed
  triggers_replace = [
    # The provisioner is executed then the `id` of the EC2 instance changes
    filemd5("${path.module}/lambda-layer/nodejs/package.json")
  ]
  provisioner "local-exec" {
    command = "cd ${path.module}/lambda-layer/nodejs && npm install && cd .. && zip -r nodejs.zip ."
  }
}
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

data "archive_file" "get_products" {
  type             = "zip"
  source_file      = "../content/getProducts.js"
  output_file_mode = "0666"
  output_path      = "${path.module}/files/getProducts.zip"
}
data "archive_file" "add_products" {
  type             = "zip"
  source_file      = "../content/addProducts.js"
  output_file_mode = "0666"
  output_path      = "${path.module}/files/addProducts.zip"
}

data "archive_file" "update_products" {
  type             = "zip"
  source_file      = "../content/updateProducts.js"
  output_file_mode = "0666"
  output_path      = "${path.module}/files/updateProducts.zip"
}

data "archive_file" "delete_products" {
  type             = "zip"
  source_file      = "../content/deleteProducts.js"
  output_file_mode = "0666"
  output_path      = "${path.module}/files/deleteProducts.zip"
}
# resource "aws_lambda_layer_version" "lambda_deps_layer" {
#   layer_name          = "shared_deps"
#   # filename            = data.archive_file.get_products.output_path
#   filename            = "${path.module}/lambda-layer/nodejs.zip"
#   # source_code_hash    = data.archive_file.get_products.output_base64sha256
#   compatible_runtimes = ["nodejs14.x", "nodejs16.x" ]
# }
# Lambda Functions
resource "aws_lambda_function" "get_products" {
  filename         = "${path.module}/files/getProducts.zip"
  function_name    = "get_products"
  role             = aws_iam_role.lambda_logging_role.arn
  handler          = "getProducts.handler"
  source_code_hash = data.archive_file.get_products.output_base64sha256
  runtime = "nodejs16.x"
  # layers = [
  #   aws_lambda_layer_version.lambda_deps_layer.arn
  # ]
}

resource "aws_lambda_function" "add_products" {
  filename         = "${path.module}/files/addProducts.zip"
  function_name    = "add_products"
  role             = aws_iam_role.lambda_logging_role.arn
  handler          = "addProducts.handler"
  source_code_hash = data.archive_file.add_products.output_base64sha256
  runtime          = "nodejs16.x"
}

resource "aws_lambda_function" "update_products" {
  filename         = "${path.module}/files/updateProducts.zip"
  function_name    = "update_product"
  role             = aws_iam_role.lambda_logging_role.arn
  handler          = "updateProducts.handler"
  source_code_hash = data.archive_file.update_products.output_base64sha256
  runtime          = "nodejs16.x"
}

resource "aws_lambda_function" "delete_product" {
  filename         = "${path.module}/files/deleteProducts.zip"
  function_name    = "delete_product"
  role             = aws_iam_role.lambda_logging_role.arn
  handler          = "deleteProducts.handler"
  source_code_hash = data.archive_file.delete_products.output_base64sha256
  runtime          = "nodejs16.x"
}