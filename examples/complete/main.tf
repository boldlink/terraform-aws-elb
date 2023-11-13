### Supporting resources
resource "tls_private_key" "example" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "example" {
  private_key_pem = tls_private_key.example.private_key_pem

  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

# S3 bucket for access logs
module "access_logs_bucket" {
  source            = "boldlink/s3/aws"
  version           = "2.3.0"
  bucket            = "${var.name}-access-logs-bucket"
  force_destroy     = true
  versioning_status = "Enabled"
  sse_sse_algorithm = var.access_logs_sse_algorithm
  bucket_policy     = data.aws_iam_policy_document.elb_s3.json
  tags              = var.tags
}

module "ec2_instances" {
  source            = "boldlink/ec2/aws"
  version           = "2.0.3"
  count             = 3
  name              = "${var.name}-${count.index}"
  ami               = data.aws_ami.amazon_linux.id
  instance_type     = "t3.small"
  monitoring        = true
  ebs_optimized     = true
  vpc_id            = local.vpc_id
  availability_zone = local.private_sub_azs[count.index % length(local.private_sub_azs)]
  subnet_id         = local.private_subnets[count.index % length(local.private_subnets)]
  tags              = merge({ "Name" = "${var.name}-${count.index}" }, var.tags)
  root_block_device = var.root_block_device
  extra_script      = templatefile("${path.module}/httpd.sh", {})
  install_ssm_agent = true

  security_group_ingress = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [var.cidr_block]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [var.cidr_block]
    }
  ]

  security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

}

resource "aws_acm_certificate" "main" {
  private_key      = tls_private_key.example.private_key_pem
  certificate_body = tls_self_signed_cert.example.cert_pem

  lifecycle {
    create_before_destroy = true
  }
}

module "complete_elb" {
  source              = "../../"
  name                = var.name
  subnets             = local.public_subnets
  security_groups     = [aws_security_group.elb.id]
  availability_zones  = data.aws_availability_zones.available.names
  connection_draining = true
  idle_timeout        = 400
  instances           = flatten(module.ec2_instances[*].id)
  tags                = local.tags

  access_logs = {
    bucket        = module.access_logs_bucket.id
    bucket_prefix = "ELBLogs"
    interval      = 60
    enabled       = true
  }

  # Health check: timeout must be less than interval
  health_check = {
    healthy_threshold   = 5
    unhealthy_threshold = 10
    timeout             = 20
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  # Listeners
  listeners = [
    {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    },
    {
      instance_port      = 80
      instance_protocol  = "http"
      lb_port            = 443
      lb_protocol        = "https"
      ssl_certificate_id = aws_acm_certificate.main.id
    }
  ]

  load_balancer_policies = {
    example-ssl = {
      policy_name      = "example-ssl"
      policy_type_name = "SSLNegotiationPolicyType"
      policy_attributes = [
        {
          name  = "ECDHE-ECDSA-AES128-GCM-SHA256"
          value = "true"
        },
        {
          name  = "Protocol-TLSv1.2"
          value = "true"
        }
      ]
    }
  }
}
