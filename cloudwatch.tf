resource "aws_cloudwatch_log_group" "zelda_cw_logs" {
  name = "aws-waf-logs-${random_string.suffix.id}"
}


resource "aws_cloudwatch_log_resource_policy" "zelda_rcw" {
  policy_document = data.aws_iam_policy_document.zelda_cloudwatch_logs.json
  policy_name     = "webacl-policy-cw-${random_string.suffix.id}"
}

data "aws_iam_policy_document" "zelda_cloudwatch_logs" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.zelda_cw_logs.arn}:*"]
    condition {
      test     = "ArnLike"
      values   = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
      variable = "aws:SourceArn"
    }
    condition {
      test     = "StringEquals"
      values   = [tostring(data.aws_caller_identity.current.account_id)]
      variable = "aws:SourceAccount"
    }
  }
}



