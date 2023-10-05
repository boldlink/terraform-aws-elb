resource "aws_security_group" "elb" {
  name        = "${var.name}-security-group"
  description = "Allow elb inbound traffic"
  vpc_id      = module.vpc.vpc_id
  tags        = local.tags
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  #checkov:skip=CKV_AWS_260:Ensure no security groups allow ingress from 0.0.0.0:0 to port 80
  security_group_id = aws_security_group.elb.id
  description       = "Rule to allow all http traffic to the elb"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.elb.id
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Rule to allow all http traffic from the elb"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
