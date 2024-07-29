# data "template_file" "config" {
#   template = "${file("${website_root}/config.tftpl")}"
#   vars = {
#     UserPoolId: "${aws_cognito_user_pool.user_pool.id}",
#     ClientId: "${aws_cognito_user_pool_client.user_pool_client.id}"
#   }
# }


# https://spacelift.io/blog/terraform-templates

# dependencie.tftpl
# ${
# jsonencode("dependencies": { 
# "cradle": ${cradle_v}, 
# "jade": ${jade_v}, 
# "redis": ${redis_v}, 
# "socket.io": ${socket_v}, 
# "twitter-node": ${twitter_v}, 
# "express": ${express_v} })
# }

# variable dep_vers {
#    default = {
#        "cradle_v": "0.5.5",
#        "jade_v": "0.10.4",
#        "redis_v": "0.5.11",
#        "socket_v": "0.6.16",
#        "twitter_v": "0.0.2",
#        "express_v": "2.2.0"
#    }
# }

# provisioner "file" {
#   source      = templatefile("dependencies.tftpl", var.dep_vers)
#   destination = "/desired/path/dependencies.json"
# }


# https://developer.hashicorp.com/terraform/language/functions/templatefile