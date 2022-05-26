module "elb" {
  source             = "../../"
  name               = "minimal-example-elb"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [data.aws_security_group.default.id]
  availability_zones = data.aws_availability_zones.available.names

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
