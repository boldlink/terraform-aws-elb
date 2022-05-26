########################################################
### ELB
########################################################
locals {
  name            = var.name
  service_account = data.aws_elb_service_account.main.arn
}

resource "aws_elb" "main" {
  name                        = local.name
  availability_zones          = var.subnets != null ? null : var.availability_zones
  name_prefix                 = var.name_prefix
  security_groups             = var.security_groups
  subnets                     = var.subnets
  instances                   = var.instances
  internal                    = var.internal
  cross_zone_load_balancing   = var.cross_zone_load_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout
  desync_mitigation_mode      = var.desync_mitigation_mode

  dynamic "listener" {
    for_each = var.listeners
    content {
      instance_port      = listener.value.instance_port
      instance_protocol  = listener.value.instance_protocol
      lb_port            = listener.value.lb_port
      lb_protocol        = listener.value.lb_protocol
      ssl_certificate_id = try(listener.value.ssl_certificate_id, null)
    }
  }

  dynamic "access_logs" {
    for_each = length(keys(var.access_logs)) == 0 ? [] : [var.access_logs]
    content {
      bucket        = var.create_access_logs_bucket ? aws_s3_bucket.access_logs.id : access_logs.value.bucket
      bucket_prefix = lookup(access_logs.value, "bucket_prefix", null)
      interval      = lookup(access_logs.value, "interval", 60)
      enabled       = lookup(access_logs.value, "enabled", true)
    }
  }

  dynamic "health_check" {
    for_each = length(keys(var.health_check)) == 0 ? [] : [var.health_check]
    content {
      healthy_threshold   = try(health_check.value.healthy_threshold, null)
      unhealthy_threshold = try(health_check.value.unhealthy_threshold, null)
      target              = try(health_check.value.target, null)
      interval            = try(health_check.value.interval, null)
      timeout             = try(health_check.value.timeout, null)
    }
  }

  tags = var.tags
}

########################################################
### S3 bucket for access logs (optional)
########################################################
resource "aws_s3_bucket" "access_logs" {
  count  = var.create_access_logs_bucket ? 1 : 0
  bucket = "${local.name}-acess-logs-bucket"
}

resource "aws_s3_bucket_policy" "access_logs" {
  count  = var.create_access_logs_bucket ? 1 : 0
  bucket = aws_s3_bucket.access_logs[0].id
  policy = data.aws_iam_policy_document.elb_s3.json
}

resource "aws_s3_bucket_public_access_block" "access_logs" {
  count                   = var.create_access_logs_bucket ? 1 : 0
  bucket                  = aws_s3_bucket.access_logs[0].bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "access_logs" {
  count  = var.create_access_logs_bucket ? 1 : 0
  bucket = aws_s3_bucket.access_logs[0].bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "trail_versioning" {
  count  = var.create_access_logs_bucket ? 1 : 0
  bucket = aws_s3_bucket.access_logs[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

########################################################
### ELB Policy: commonly for ssl negotiation
########################################################
resource "aws_load_balancer_policy" "main" {
  for_each           = var.load_balancer_policies
  load_balancer_name = aws_elb.main.name
  policy_name        = try(each.value.policy_name, each.key)
  policy_type_name   = try(each.value.policy_type_name, each.key)
  dynamic "policy_attribute" {
    for_each = try([each.value.policy_attribute], [])
    content {
      name  = lookup(policy_attribute.value, "name", null)
      value = lookup(policy_attribute.value, "value", null)
    }
  }
}
