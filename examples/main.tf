provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

module "elb" {
  source             = "./.."
  name               = "${random_string.random.id}-elb"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [data.aws_security_group.default.id]
  availability_zones = data.aws_availability_zones.available.names
  idle_timeout       = 400
  health_check = {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }
  listener = [
    {
      instance_port     = 8080
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    }
  ]
}

output "outputs" {
  value = [
    module.elb,
  ]
}
