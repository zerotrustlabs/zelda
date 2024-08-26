locals {
  website_files = fileset(var.website_root, "**")

  file_hashes = {
    for filename in local.website_files :
    filename => filemd5("${var.website_root}/${filename}")
  }

  mime_types    = jsondecode(file("mime.json"))
  attach_policy = var.attach_require_latest_tls_policy || var.attach_deny_incorrect_encryption_headers || var.attach_deny_incorrect_kms_key_sse || var.attach_deny_unencrypted_object_uploads || var.attach_policy
  grants        = try(jsondecode(var.grant), var.grant)
  #   cors_rules           = try(jsondecode(var.cors_rule), var.cors_rule)
  lifecycle_rules   = try(jsondecode(var.lifecycle_rule), var.lifecycle_rule)
  create_bucket     = var.create_bucket
  create_bucket_acl = (var.acl != null && var.acl != "null") || length(local.grants) > 0
  authrole          = "${var.project_prefix}-authrole"
  unauthrole        = "${var.project_prefix}-unauthrole"
}