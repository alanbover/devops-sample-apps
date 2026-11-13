locals {
  database_tags     = { Name = var.identifier }
  subnet_group_tags = { Name = "${var.identifier}-subnets" }
  security_group_tags = {
    Name = "${var.identifier}-database"
  }
}
