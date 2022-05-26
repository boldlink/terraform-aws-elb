############################
### Supporting resources
############################
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

resource "aws_acm_certificate" "main" {
  private_key      = tls_private_key.example.private_key_pem
  certificate_body = tls_self_signed_cert.example.cert_pem
}

############################
module "complete_elb" {
  source             = "../../"
  name               = "complete-example-elb"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [data.aws_security_group.default.id]
  availability_zones = data.aws_availability_zones.available.names
  idle_timeout       = 400

  ## S3 Access logs bucket
  create_access_logs_bucket = true

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
}
