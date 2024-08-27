package fugue.regula.config


waivers[waiver] {
  waiver := {
      #Waiving the bucket logging rule for the logging bucket
    "rule_id": "FG_R00274",
    "resource_id": "aws_s3_bucket.this[0]"
  }
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
    "status": "DISABLED"
  },
  ]
}