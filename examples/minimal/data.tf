data "aws_vpc" "supporting" {
  filter {
    name   = "tag:Name"
    values = [var.supporting_resources_name]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["${var.supporting_resources_name}*.pub.*"]
  }
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.supporting.id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
