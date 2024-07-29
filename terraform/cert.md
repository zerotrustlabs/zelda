https://blog.demir.io/setup-an-s3-cloudfront-website-with-terraform-268d5230f05
https://blog.demir.io/setup-an-s3-cloudfront-website-with-terraform-268d5230f05



resource "aws_acm_certificate" "cert-my-aws-project-com" {
  domain_name       = "my-aws-project.com"
  validation_method = "DNS"
    subject_alternative_names = ["www.my-aws-project.com", "my-aws-project.com"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert-validation" {
  certificate_arn         = aws_acm_certificate.cert-my-aws-project-com.arn
  validation_record_fqdns = [for record in aws_route53_record.cert-validation-record : record.fqdn]
}


resource "aws_route53_record" "cert-validation-record" {
  for_each = {
    for dvo in aws_acm_certificate.cert-my-aws-project-com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.my-aws-project.zone_id
}

<!--  -->

resource "aws_route53_zone" "my-aws-project" {
  name = "my-aws-project.com."
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.my-aws-project.zone_id
  name    = "www"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.my-distribution.domain_name
    zone_id                = aws_cloudfront_distribution.my-distribution.hosted_zone_id
    evaluate_target_health = false
  }

}