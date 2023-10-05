locals {
  tags            = merge({ "Name" = var.name }, var.tags)
  azs             = data.aws_availability_zones.available.names
  service_account = data.aws_elb_service_account.main.arn
  public_subnets  = [cidrsubnet(var.cidr_block, 8, 1), cidrsubnet(var.cidr_block, 8, 2), cidrsubnet(var.cidr_block, 8, 3)]
  private_subnets = [cidrsubnet(var.cidr_block, 8, 4), cidrsubnet(var.cidr_block, 8, 5), cidrsubnet(var.cidr_block, 8, 6)]
}