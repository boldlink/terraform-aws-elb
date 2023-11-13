locals {
  public_subnets = flatten(local.public_subnet_id)
  tags           = merge({ "Name" = var.name }, var.tags)

  public_subnet_id = [
    for i in data.aws_subnet.public : i.id
  ]
}
