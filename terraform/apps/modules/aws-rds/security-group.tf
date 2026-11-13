resource "aws_security_group" "database" {
  name        = "${var.identifier}-database"
  description = "PostgreSQL access for ${var.identifier}"
  vpc_id      = var.vpc_id
  tags        = local.security_group_tags
}

resource "aws_vpc_security_group_ingress_rule" "postgresql" {
  for_each = var.allowed_security_groups

  security_group_id            = aws_security_group.database.id
  referenced_security_group_id = each.value
  description                  = "PostgreSQL from ${each.key}"
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}
