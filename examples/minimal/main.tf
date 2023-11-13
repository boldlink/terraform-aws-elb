module "elb" {
  source             = "../../"
  name               = var.name
  subnets            = local.public_subnets
  security_groups    = [data.aws_security_group.default.id]
  availability_zones = data.aws_availability_zones.available.names
  tags               = local.tags

  # Listeners
  listeners = [
    {
      instance_port     = 8080
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    }
  ]
}
