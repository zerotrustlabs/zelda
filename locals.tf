locals {
  website_files = fileset(var.website_root, "**")

  file_hashes = {
    for filename in local.website_files :
    filename => filemd5("${var.website_root}/${filename}")
  }

  mime_types = jsondecode(file("mime.json"))

  create_bucket = var.create_bucket
  authrole      = "${var.project_prefix}-authrole"
  unauthrole    = "${var.project_prefix}-unauthrole"
}