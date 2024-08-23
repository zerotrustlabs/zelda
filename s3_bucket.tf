resource "aws_s3_bucket" "photo_bucket" {
  bucket = "${var.project_prefix}-ztls"

  tags = (merge(
    tomap({ "Application" = "${var.project_prefix}" }),
    tomap({ "Managed" = "Terraform" })
  ))
}