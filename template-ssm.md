resource "local_file" "templated" {
  content = templatefile("${path.module}/edge-cache-request-signer/index.js", {
    ssm_prefix = var.project_prefix,
  })
  filename = "${path.module}/edge-cache-request-signer/deploy/index.js"
}

data "archive_file" "EdgeCacheRequestSignerArchive" {
  depends_on = [
    local_file.templated
  ]
  type        = "zip"
  source_dir  = "${path.module}/edge-cache-request-signer/deploy"
  output_path = "${path.module}/edge-cache-request-signer/deploy/edge-cache-request-signer.zip"
}

use of template - "${path.module}/edge-cache-request-signer/deploy/index.js"
const setDomainCacheValue = async () => {
  if (cache.cloudfrontDomain == null) {
    cache.cloudfrontDomain = await loadParameter(
      `${ssm_prefix}-cloudfront-domain`
    );
  }
};

SSM Keyrotation:
https://github.com/madvonh/cloudfront-cognito-signed-cookies-terraform/blob/main/secretsmanager_secret.tf