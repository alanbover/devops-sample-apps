resource "aws_security_group" "bastion" {
  name        = var.name
  description = "Outbound-only SSM host for ${var.name}"
  vpc_id      = var.vpc_id
}
