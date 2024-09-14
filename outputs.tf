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
output "waf_arn" {
  value       = aws_wafv2_web_acl.zelda_cf_waf.arn
  description = "IP sets arn"
}
output "waf_ipsets_cf_ipv4_arn" {
  value       = aws_wafv2_ip_set.blacklist_cf_ipv4.arn
  description = "IP sets arn"
}
# output "guardduty" {
#   description = "AWS GuardDuty Detector Standalone"
#   value       = module.guardduty
# }


# output "standalone" {
#   description = "AWS GuardDuty Detector Standalone"
#   value       = module.standalone_guardduty
# }

output "security_hub" {
  description = "AWS Security Hub Standalone deploymeent"
  value       = module.security_hub
}

output "standards_control" {
  description = "AWS Security Hub Standards Control Customization"
  value       = aws_securityhub_standards_control.ensure_iam_password_policy_prevents_password_reuse
}

output "insights" {
  description = "AWS Security Hub Custom Insights"
  value       = aws_securityhub_insight.this
}