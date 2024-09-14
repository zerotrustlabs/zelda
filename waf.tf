resource "aws_wafv2_web_acl" "zelda_cf_waf" {
    name        = "managed-acfp-example"
    description = "Example of a managed ACFP rule."
    scope       = "CLOUDFRONT"

    default_action {
        allow {}
    }
  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 20

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSetMetric"
      sampled_requests_enabled   = true
    }
  }
    visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = "friendly-metric-name"
        sampled_requests_enabled   = false
    }
}




resource "aws_wafv2_ip_set" "blacklist_cf_ipv4" {
    name               = "${var.project_prefix}-cf-ipv4"
    scope              = "CLOUDFRONT"
    # provider           = aws.us-east-1
    ip_address_version = "IPV4"
    addresses          = ["127.0.0.1/32"]

    tags = {
        Name = "${var.project_prefix}-cf-ipv4"
    }
}

resource "aws_wafv2_ip_set" "blacklist_cf_ipv6" {
    name               = "${var.project_prefix}-cf-ipv6"
    scope              = "CLOUDFRONT"
    # provider           = aws.us-east-1
    ip_address_version = "IPV6"
    addresses          = ["2001:0db8:0000:0000:0000:0000:0000:0001/128"]

    tags = {
        Name = "${var.project_prefix}-cf-ipv6"
    }
}





# aws_wafv2_web_acl_association not required for cloudfront distribution
# resource "aws_wafv2_web_acl_association" "api_server_waf" {
#   resource_arn = module.hoge_hoge_alb.alb_arn
#   web_acl_arn  = module.waf_alb.waf_arn
# }

# module "waf_cf" {
#   source       = "../../modules/waf_cf"
#   prefix       = local.prefix
#   name         = "waf-teacher"
#   metric_name  = "waf-teacher"
#   cf_ipsets_v4 = module.waf_ipsets.waf_ipsets_cf_ipv4_arn
#   cf_ipsets_v6 = module.waf_ipsets.waf_ipsets_cf_ipv6_arn
#   bucket = "aws-waf-logs-teacher-prd-blah-blah"
# }

# module "cloudfront_waf" {
#   source          = "../../modules/cloudfront_spa_cdn"
#   prefix          = local.prefix
#   name            = "spa-frontend"
#   cloudfront_fqdn = local.hoge_teacher_web_frontend_fqdn
#   zone_id         = module.route53_zone.zone_id
#   web_acl_id      = module.waf_teacher.waf_arn
# }
# bucket name must be prefixed with aws-waf-logs-, e.g. aws-waf-logs-example-firehose, aws-waf-logs-example-log-group, or aws-waf-logs-example-bucket.
# resource "aws_wafv2_web_acl_logging_configuration" "api_server_waf_log" {
#   log_destination_configs = [aws_s3_bucket.aws-waf-logs-bucket.arn]
#   resource_arn            = aws_wafv2_web_acl.zelda_cf_waf.arn
# }
resource "aws_wafv2_web_acl_logging_configuration" "example" {
  log_destination_configs = [aws_cloudwatch_log_group.zelda_cw_logs.arn]
  resource_arn            = aws_wafv2_web_acl.zelda_cf_waf.arn
}

# WAF RULES SET
#   rule {
#     name     = "AWSRateBasedRuleDomesticDOS"
#     priority = 1

#     action {
#       block {}
#     }

#     statement {
#       rate_based_statement {
#         limit              = 2000
#         aggregate_key_type = "IP"

#         scope_down_statement {
#           geo_match_statement {
#             country_codes = ["JP"]
#           }
#         }
#       }
#     }
#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWSRateBasedRuleDomesticDOS"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWSRateBasedRuleGlobalDOS"
#     priority = 2

#     action {
#       block {}
#     }

#     statement {
#       rate_based_statement {
#         limit              = 500
#         aggregate_key_type = "IP"

#         scope_down_statement {
#           not_statement {
#             statement {
#               geo_match_statement {
#                 country_codes = ["JP"]
#               }
#             }
#           }
#         }
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWSRateBasedRuleGlobalDOS"
#       sampled_requests_enabled   = true
#     }
#   }
