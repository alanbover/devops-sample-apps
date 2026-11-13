resource "postgresql_role" "user" {
  for_each = local.users

  name  = each.key
  login = each.value.enabled
  roles = each.value.enabled ? ["rds_iam", postgresql_role.group[each.value.role].name] : []

  lifecycle {
    precondition {
      condition = (
        can(regex("^[a-z][a-z0-9_-]{0,62}$", each.key)) &&
        !startswith(each.key, "pg_") &&
        !startswith(each.key, "rds_") &&
        !contains([var.master_username, "postgres", "app_readonly", "app_readwrite"], each.key) &&
        contains(keys(local.groups), each.value.role)
      )
      error_message = "Each user needs a safe PostgreSQL role name and readonly or readwrite access."
    }
  }
}
