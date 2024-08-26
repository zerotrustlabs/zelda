package rules.allow_s3_logging
import data.fugue
__rego__metadoc__ := {
  "id": "CUSTOM_0001",
  "title": "IAM policies must have a description of at least 25 characters",
  "description": "Per company policy, it is required for all IAM policies to have a description of at least 25 characters.",
  "custom": {
    "controls": {
      "CORPORATE-POLICY": [
        "CORPORATE-POLICY_1.1"
      ]
    },
    "severity": "Low"
  }
}
input_type= "tf"
resource_type = "MULTIPLE"
buckets = fugue.resources("aws_s3_bucket")

policy[r] {
  bucket = buckets[_]
  bucket.tags.Managed == "Terraform"
  r = fugue.allow_resource(bucket)
} 