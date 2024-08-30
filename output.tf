output "website_url" {
  value = aws_s3_bucket.this.website_endpoint
}

output "user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "identity_pool_id" {
  value = aws_cognito_identity_pool.identity_pool.id
}
output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
}
output "s3_bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "cwd" {
  value = path.cwd
}

output "module" {
  value = path.module
}
output "root" {
  value = path.root
}

output "cloudfrontid" {
  value = aws_cloudfront_origin_access_identity.origin_access_identity.id
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.zeld_prod_distribution.domain_name
}