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

module "vpc" {
  source                 = "boldlink/vpc/aws"
  version                = "3.1.0"
  name                   = var.name
  cidr_block             = var.cidr_block
  enable_dns_support     = true
  enable_dns_hostnames   = true
  enable_public_subnets  = true
  enable_private_subnets = true
  tags                   = var.tags

  public_subnets = {
    public = {
      cidrs                   = local.public_subnets
      map_public_ip_on_launch = true
      nat                     = "single"
    }
  }

  private_subnets = {
    private = {
      cidrs = local.private_subnets
    }
  }
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

#module "ec2_instances"{
#  source = "boldlink/ec2/aws"
#  version = "2.0.0"
#  count = 2
#    name              = "${var.name}-count.index"
#  ami               = data.aws_ami.amazon_linux.id
#  instance_type     = "t3.small"
#  monitoring        = true
#  ebs_optimized     = true
#  vpc_id            = module.vpc.vpc_id
#  availability_zone = local.azs
#  subnet_id         = module.vpc.private_subnet_ids[0]
#  tags              = local.tags
#  root_block_device = var.root_block_device
#}

module "ec2_instances" {
  source            = "boldlink/ec2/aws"
  version           = "2.0.0"
  count             = 3
  name              = "${var.name}-${count.index}"
  ami               = data.aws_ami.amazon_linux.id
  instance_type     = "t3.small"
  monitoring        = true
  ebs_optimized     = true
  vpc_id            = module.vpc.vpc_id
  availability_zone = local.azs[count.index % length(local.azs)]
  subnet_id         = module.vpc.private_subnet_ids[count.index % length(module.vpc.private_subnet_ids)]
  tags              = merge({ "Name" = "${var.name}-${count.index}" }, var.tags)
  root_block_device = var.root_block_device
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
  name                = "complete-example-elb"
  subnets             = module.vpc.private_subnet_ids
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
    unhealthy_threshold = 6
    timeout             = 20
    target              = "HTTP:8000/"
    interval            = 30
  }

  # Listeners
  listeners = [
    {
      instance_port     = 8080
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    },
    {
      instance_port      = 3000
      instance_protocol  = "http"
      lb_port            = 3000
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
