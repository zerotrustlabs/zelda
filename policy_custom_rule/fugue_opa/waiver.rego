package fugue.regula.config


waivers[waiver[_]] {
  waiver := [{
      #Waiving the bucket logging rule for the logging bucket
    "rule_id": "FG_R00274",
    "resource_id": "aws_s3_bucket.this[0]"
  },
    {
      #Waiving the log bucket Allow HTTP: S3 bucket policies should only allow requests that use HTTPS
    "rule_id": "FG_R00100",
    "resource_id": "aws_s3_bucket.log_bucket",
  },
{
      #Waiving the log bucket: S3 bucket versioning and lifecycle policies should be enabled
    "rule_id": "FG_R00101",
    "resource_id": "aws_s3_bucket.log_bucket",
  },
  ]
}



rules[rule[_]] {
  rule := [{
    #Disabling this cross-region replication rule for budgetary purposes
    "rule_id": "FG_R00275",
    "status": "DISABLED"
  },
  {
    #Disabling this cross-region replication rule for budgetary purposes
    "rule_id": "FG_R00355",
    "status": "DISABLED"
  },
    {
    #Disabling S3 bucket server-side encryption for static s3 website
    "rule_id": "FG_R00355",
    "status": "ENABLED"
  },
    {
    #Disabling Cloudtrail: S3 bucket object-level logging for write events should be enabled
    "rule_id": "FG_R00354",
    "status": "DISABLED"
  },
 {
    #Disabling Cloudtrail: S3 bucket object-level logging for write events should be enabled
    "rule_id": "FG_R00354",
    "status": "DISABLED"
  },
  {
    #Disabling "S3 bucket policies should only allow requests that use HTTPS
    "rule_id": "FG_R00100",
    "status": "DISABLED"
  },
  ]
}