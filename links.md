[603825719481_AdministratorAccess]
Solution
https://medium.com/@jith/a-practical-introduction-to-aws-lambda-api-gateway-cognito-dynamo-db-s3-hosting-and-60002b22947a

https://github.com/gitjit/blog/blob/master/cognito_auth/signin.html
https://medium.com/@jith/a-practical-introduction-to-aws-lambda-api-gateway-cognito-dynamo-db-s3-hosting-and-60002b22947a

cognito
https://github.com/mineiros-io/terraform-aws-cognito-user-pool/blob/master/main.tf
https://github.com/madvonh/cloudfront-cognito-signed-cookies-terraform/blob/main/s3_bucket.tf
Use Terraform to create an AWS CloudFront distribution from S3 secured with Cognito, Signed Cookie and Lambda@Edge
Use Terraform to create an AWS CloudFront distribution from S3 secured with Cognito, Signed Cookie and Lambda@Edge

Secret Manager
https://webstep.se/nyheter--blogginlagg/blogginlagg/use-terraform-to-create-an-aws-cloudfront-distribution

S3 Bucket
https://github.com/madvonh/cloudfront-cognito-signed-cookies-terraform/blob/main/s3_bucket.tf
https://github.com/terraform-aws-modules/terraform-aws-s3-bucket/blob/master/main.tf
https://github.com/cn-terraform/terraform-aws-s3-static-website/blob/main/website.tf

https://github.com/aws-samples/s3-presignedurl-staticips-endpoint-with-terraform/blob/main/2.apigw_s3_lambda/main.tf

CloudFront Token:
https://aws.amazon.com/blogs/networking-and-content-delivery/authorizationedge-using-cookies-protect-your-amazon-cloudfront-content-from-being-downloaded-by-unauthenticated-users/

API Gateway Apps
https://github.com/davidpaulmcintyre/cra-todo/blob/master/src/actions/todo.js

API GATEWAY SERVERLESS
https://vinisantos.dev/posts/hands-on-aws-agw-terraform-sls-framework-part-3
https://github.com/aws-samples/apigateway-deployment-lifecycle-management-terraform/blob/main/main.tf
https://github.com/aws-samples/apigateway-deployment-lifecycle-management-terraform/blob/main/main.tf
https://github.com/aws-samples/apigateway-deployment-lifecycle-management-terraform/blob/main/logging.tf
https://github.com/gitjit/blog/blob/master/cloud_friends/js/apiGateway-js-sdk/apigClient.js
APIGATEWAY CERT: https://github.com/hashicorp/terraform-provider-aws/blob/main/examples/api-gateway-rest-api-openapi/domain.tf


AWS OPA
https://github.com/aws-samples/aws-infra-policy-as-code-with-terraform/blob/main/policy-as-code/OPA/policy/aws/apigateway/aws-apigateway-m-1.rego
https://github.com/aws-samples/aws-infra-policy-as-code-with-terraform/blob/main/policy-as-code/OPA/policy/common.utils.rego
https://github.com/aws-samples/aws-infra-policy-as-code-with-terraform/blob/main/policy-as-code/OPA/policy/common.utils.rego

EventBus
https://github.com/terraform-aws-modules/terraform-aws-eventbridge/blob/master/main.tf

APIGATEWAY:
https://medium.com/@jith/a-practical-introduction-to-aws-lambda-api-gateway-cognito-dynamo-db-s3-hosting-and-60002b22947a

vpn:
https://github.com/pomerium/pomerium
openziti: https://netfoundry.io/netfoundry-partners/

GuardDuty Terraform
https://www.easydeploy.io/blog/aws-guardduty-enabling/
https://arshpunia.medium.com/anomaly-detection-with-aws-sagemaker-cloudtrail-and-guardduty-779eaa4c1d2e
How to Configure Automated Incident Response for Amazon GuardDuty Findings with Terraform
[How to Configure Automated Incident Response for Amazon GuardDuty Findings with Terraform](https://community.aws/content/2iCigc8q3Jx9kpT40atumUiGIB1/using-terraform-to-configure-automated-guardduty-findings?lang=en)
https://community.aws/content/2iCigc8q3Jx9kpT40atumUiGIB1/using-terraform-to-configure-automated-guardduty-findings?lang=en

WAF
https://gist.github.com/masayoshi644/13e9d17efec808f05e98b057439edfc1
https://dev.to/aws-builders/how-to-setup-aws-waf-v2-21f1
https://github.com/aws-samples/aws-waf-firewall-manager-terraform/blob/main/4-fwm-waf-logging-option2_regional.tf
https://github.com/aws-samples/aws-waf-automation-terraform-samples/blob/main/main.tf


cedar:
https://github.com/aws-samples/cedar-policy-validation-pipeline?tab=readme-ov-file
https://catalog.workshops.aws/cedar-policy-language-in-action/en-US/20-tutorial/26-fullexample

NIST:
https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-61r2.pdf
CIS Controls;
https://www.cisecurity.org/controls
Regula Fugue
https://github.com/fugue/regula-action
https://github.com/fugue/custom-rules/blob/master/advanced/Advanced_AWS.S3_BucketsCloudTrailLogs.rego
https://github.com/fugue/regula-ci-example/blob/master/infra_tf/main.tf

SYNK Policy Engine:
https://github.com/snyk/policy-engine/
https://github.com/snyk/policy-engine/blob/main/examples/03-advanced.rego
https://github.com/snyk/policy-engine/blob/main/examples/metadata/rules/snyk_007/metadata.json
SYNK - GITHUBACTIONS
https://github.com/snyk/actions?tab=readme-ov-file
ALL RULES
https://security.snyk.io/rules/cloud/
https://docs.snyk.io/scm-ide-and-ci-cd-integrations/snyk-ci-cd-integrations/github-actions-for-snyk-setup-and-checking-for-vulnerabilities
Terraform - Files Test
https://docs.snyk.io/snyk-cli/scan-and-maintain-projects-using-the-cli/snyk-cli-for-iac/test-your-iac-files/terraform-files

ADVANCED
https://github.com/fugue/custom-rules/blob/master/old_metadata_format/advanced/Advanced_AWS.MultiResource_AllTaggableResourcesRequireTags.rego
WAIVER LOGGING RULES - https://github.com/fugue/fugue-scalr-integration/blob/main/waivers.rego
Regula Docker -  https://github.com/fugue/regula-action/blob/master/scripts/local.sh
Regula & Scalr - https://www.fugue.co/blog/automating-terraform-security-in-scalr-deployments-with-regula-tutorial
rule list - https://regula.dev/rules.html
https://docs.fugue.co/rules.html
Waive and Disable Rule - https://regula.dev/examples/waive-and-disable.html

RELEASE NOTES: https://docs.fugue.co/releasenotes.html#r20220629
RULE REFERENCE - https://docs.fugue.co/rules-reference.html
SYNK REGULA: https://snyk.io/blog/checking-aws-ami-ids-in-terraform-using-regula-and-open-policy-agent/
FUGUE PROJECT - https://github.com/fugue-project/fugue
jupyter book
https://jupyterbook.org/en/stable/start/publish.html
Video Sample: https://www.youtube.com/watch?v=ThbtoFRV704

Cognito - https://github.com/awslabs/aws-support-tools/blob/master/Cognito/decode-verify-jwt/decode-verify-jwt.ts
COGNITO - https://aws.amazon.com/blogs/security/implement-step-up-authentication-with-amazon-cognito-part-1-solution-overview/

package fugue.regula.config

waivers[waiver] {
  waiver := {
    "rule_name": "long_description",
    "resource_id": "aws_iam_policy.basically_allow_all"
  }
}

Disable A rule
rules[rule] {
  rule := {
    "rule_name": "tf_aws_iam_admin_policy",
    "status": "DISABLED"
  }
}
regula run -f json --include example_custom_rule --include config.rego infra_tf

package rules.my_simple_rule

# Simple rules must specify the resource type they will police.
resource_type = "aws_ebs_volume"

# Simple rules must specify `allow` or `deny`.  For this example, we use
# an `allow` rule to check that the EBS volume is encrypted.
default allow = false
allow {
  input.encrypted == true
}
===
package rules.simple_rule_custom_message
resource_type = "aws_ebs_volume"

deny[msg] {
  not input.encrypted
  msg = "EBS volumes should be encrypted"
}

====

ADVANCED RULE - https://regula.dev/development/writing-rules.html
https://docs.fugue.co/rules-advanced.html
INSTALL REGULA - https://regula.dev/getting-started.html
https://github.com/fugue/custom-rules/blob/master/advanced/Advanced_AWS.S3_TaggedPrivateACL.rego

# Rules still must be located in the `rules` package.
package rules.user_attached_policy

# Advanced rules typically use functions from the `fugue` library.
import data.fugue

# We mark an advanced rule by setting `resource_type` to `MULTIPLE`.
resource_type = "MULTIPLE"

# `fugue.resources` is a function that allows querying for resources of a
# specific type.  In our case, we are just going to ask for the EBS volumes
# again.
ebs_volumes = fugue.resources("aws_ebs_volume")

# Auxiliary function.
is_encrypted(resource) {
  resource.encrypted == true
}

# Regula expects advanced rules to contain a `policy` rule that holds a set
# of _judgements_.
policy[p] {
  resource = ebs_volumes[_]
  is_encrypted(resource)
  p = fugue.allow_resource(resource)
} {
  resource = ebs_volumes[_]
  not is_encrypted(resource)
  p = fugue.deny_resource(resource)
}
=====

policy[r] {
  bucket = buckets[_]
  bucket.tags.stage == "prod"
  r = fugue.allow_resource(bucket)
} {
  bucket = buckets[_]
  bucket.tags.stage == "prod"
  r = fugue.deny_resource(bucket)
}


terraform-aws-modules/s3-bucket/aws module, simply use:

# S3 Bucket Ownership Controls
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls
control_object_ownership = true
object_ownership         = "BucketOwnerPreferred"



Anomaly detection with guardduty
https://gist.github.com/arshpunia
https://arshpunia.medium.com/anomaly-detection-with-aws-sagemaker-cloudtrail-and-guardduty-779eaa4c1d2e

API Gateway ALB
https://github.com/aws-samples/s3-presignedurl-staticips-endpoint-with-terraform/blob/main/2.apigw_s3_lambda/main.tf
APIGATEWAY FLOW
https://andrewtarry.com/posts/aws-http-gateway-with-cognito-and-terraform/

eks sETUP
https://andrewtarry.com/posts/terraform-eks-alb-setup/

Rewrite S3 bUCKET AND oBJECTS WITH MODULES
https://github.com/terraform-aws-modules/terraform-aws-s3-bucket/blob/master/modules/object/main.tf

route 53
https://github.com/cloudmaniac/terraform-aws-static-website/blob/main/main.tf
EVENT BRIDGE
Use Terraform to create an AWS CloudFront distribution from S3 secured with Cognito, Signed Cookie and Lambda@Edge
https://github.com/terraform-aws-modules/terraform-aws-eventbridge/blob/master/main.tf