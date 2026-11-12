resource "postgresql_role" "group" {
  for_each = local.groups

  name  = each.value.name
  login = false
}

resource "postgresql_grant" "database" {
  for_each = local.groups

  database    = var.database_name
  role        = postgresql_role.group[each.key].name
  object_type = "database"
  privileges  = ["CONNECT"]
}

resource "postgresql_grant" "schema" {
  for_each = local.groups

  database    = var.database_name
  role        = postgresql_role.group[each.key].name
  schema      = "public"
  object_type = "schema"
  privileges  = ["USAGE"]
}

resource "postgresql_grant" "tables" {
  for_each = local.groups

  database    = var.database_name
  role        = postgresql_role.group[each.key].name
  schema      = "public"
  object_type = "table"
  privileges  = each.value.table_privileges
}

resource "postgresql_grant" "sequences" {
  for_each = local.groups

  database    = var.database_name
  role        = postgresql_role.group[each.key].name
  schema      = "public"
  object_type = "sequence"
  privileges  = each.value.sequence_privileges
}

resource "postgresql_default_privileges" "tables" {
  for_each = local.groups

  database    = var.database_name
  owner       = var.master_username
  role        = postgresql_role.group[each.key].name
  schema      = "public"
  object_type = "table"
  privileges  = each.value.table_privileges
}

resource "postgresql_default_privileges" "sequences" {
  for_each = local.groups

  database    = var.database_name
  owner       = var.master_username
  role        = postgresql_role.group[each.key].name
  schema      = "public"
  object_type = "sequence"
  privileges  = each.value.sequence_privileges
}
