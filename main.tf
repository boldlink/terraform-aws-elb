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
    for_each = var.create_access_logs_bucket == false ? [] : [var.access_logs]
    content {
      bucket        = try(module.access_logs[0].id, access_logs.value.bucket)
      bucket_prefix = try(access_logs.value.bucket_prefix, null)
      interval      = try(access_logs.value.interval, 60)
      enabled       = try(access_logs.value.enabled, true)
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
module "access_logs" {
  count                  = var.create_access_logs_bucket ? 1 : 0
  source                 = "boldlink/s3/aws"
  version                = "2.3.0"
  bucket                 = "${local.name}-acess-logs-bucket"
  force_destroy          = true
  versioning_status      = "Enabled"
  sse_sse_algorithm      = var.access_logs_sse_algorithm
  bucket_policy          = data.aws_iam_policy_document.elb_s3.json
  sse_kms_master_key_arn = var.access_logs_sse_algorithm == "aws:kms" ? var.access_logs_kms_id : null
  tags                   = var.tags
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
