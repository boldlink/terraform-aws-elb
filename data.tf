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
      "${try(aws_s3_bucket.access_logs[0].arn, "")}/*",
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
    resources = ["${try(aws_s3_bucket.access_logs[0].arn, "")}/*"]
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
    resources = [try(aws_s3_bucket.access_logs[0].arn, "")]
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
  }

  dynamic "statement" {
    for_each = var.elb_additional_s3_policy
    content {
      sid = try(statement.value.sid, null)

      actions = try(statement.value.actions, null)

      effect = try(statement.value.effect, null)

      dynamic "principals" {
        for_each = try([statement.value.principals], [])
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try([statement.value.condition], [])

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}
