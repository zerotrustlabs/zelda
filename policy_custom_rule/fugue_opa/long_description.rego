# Policies must have description of at least 25 characters.
package rules.long_description

__rego__metadoc__ := {
  "id": "CUSTOM_0002",
  "title": "IAM policies must have a description of at least 25 characters",
  "description": "Per company policy, it is required for all IAM policies to have a description of at least 25 characters.",
  "custom": {
    "controls": {
      "CORPORATE-POLICY": [
        "CORPORATE-POLICY_2.0"
      ]
    },
    "severity": "Low"
  }
}

resource_type = "aws_iam_policy"

default allow = false

allow {
  count(input.description) >= 25
}