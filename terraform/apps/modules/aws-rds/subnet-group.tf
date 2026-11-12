resource "aws_db_subnet_group" "database" {
  name       = "${var.identifier}-subnets"
  subnet_ids = var.private_subnet_ids
  tags       = local.subnet_group_tags
}
