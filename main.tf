########################################################
### ELB
########################################################
resource "aws_elb" "main" {
  name                        = var.name
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
    for_each = var.listener
    content {
      instance_port      = listener.value.instance_port
      instance_protocol  = listener.value.instance_protocol
      lb_port            = listener.value.lb_port
      lb_protocol        = listener.value.lb_protocol
      ssl_certificate_id = listener.value.lb_protocol == "HTTPS" || listener.value.lb_protocol == "SSL" ? lookup(listener.value, "ssl_certificate_id", null) : null
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

  health_check {
    healthy_threshold   = lookup(var.health_check, "healthy_threshold")
    unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold")
    target              = lookup(var.health_check, "target")
    interval            = lookup(var.health_check, "interval")
    timeout             = lookup(var.health_check, "timeout")
  }
  tags = var.tags
}

########################################################
### S3 bucket for access logs (optional)
########################################################
resource "aws_s3_bucket" "access_logs" {
  count  = var.create_access_logs_bucket ? 1 : 0
  bucket = "${var.name}-acess-logs-bucket"
}
########################################################
### ELB Policy
########################################################
resource "aws_load_balancer_policy" "main" {
  count              = var.policy_name != null ? 1 : 0
  load_balancer_name = aws_elb.main.name
  policy_name        = var.policy_name
  policy_type_name   = var.policy_type_name
  dynamic "policy_attribute" {
    for_each = var.loadbalancer_policy_attribute
    content {
      name  = lookup(policy_attribute.value, "name", null)
      value = lookup(policy_attribute.value, "value", null)
    }
  }
}
