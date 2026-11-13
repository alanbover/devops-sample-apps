resource "aws_security_group" "bastion" {
  name        = var.name
  description = "Outbound-only SSM host for ${var.name}"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "ssm" {
  security_group_id = aws_security_group.bastion.id
  description       = "SSM control channel through NAT"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}
