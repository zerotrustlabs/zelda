# resource "null_resource" "cognito_user" {

#   triggers = {
#     user_pool_id = aws_cognito_user_pool.pool.id
#   }

#   provisioner "local-exec" {
#     command = "aws cognito-idp admin-create-user --user-pool-id ${aws_cognito_user_pool.pool.id} --username myuser"
#   }
# }




resource "null_resource" "zip_lambda" {
  provisioner "local-exec" {
    # command     = "zip lambda_function.zip post_auth.py"
    # working_dir = "${path.cwd}"
    command = "cat post_auth.py"
  }
}

# resource "terraform_data" "example1" {
#   provisioner "local-exec" {
#     command = "open WFH, '>completed.txt' and print WFH scalar localtime"
#     interpreter = ["/bin/bash", "-c"]
#   }
# }