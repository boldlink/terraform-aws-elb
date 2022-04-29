data "aws_elb_service_account" "main" {}

### Elb Bucket Policy
data "aws_iam_policy_document" "elb_s3" {
  policy_id = "s3_bucket_lb_logs"

  statement {
    actions = [
      "s3:PutObject",
    ]
    effect = "Allow"
    resources = [
      "${join("", aws_s3_bucket.access_logs.*.arn)}/*",
    ]

    principals {
      identifiers = ["${local.service_account}"]
      type        = "AWS"
    }
  }

  statement {
    actions = [
      "s3:PutObject"
    ]
    effect    = "Allow"
    resources = ["${join("", aws_s3_bucket.access_logs.*.arn)}/*"]
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
  }

  statement {
    actions = [
      "s3:GetBucketAcl"
    ]
    effect    = "Allow"
    resources = ["${join("", aws_s3_bucket.access_logs.*.arn)}"]
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
  }
}
