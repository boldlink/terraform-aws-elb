data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-*-${var.architecture}-gp2"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

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
      "${try(module.access_logs_bucket.arn, "")}/*",
    ]

    principals {
      identifiers = [local.service_account]
      type        = "AWS"
    }
  }

  statement {
    actions = [
      "s3:PutObject"
    ]
    effect    = "Allow"
    resources = ["${try(module.access_logs_bucket.arn, "")}/*"]
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
    resources = [try(module.access_logs_bucket.arn, "")]
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
  }
}
