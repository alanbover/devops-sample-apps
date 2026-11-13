locals {
  groups = {
    readonly = {
      name                = "app_readonly"
      table_privileges    = ["SELECT"]
      sequence_privileges = ["SELECT"]
    }
    readwrite = {
      name                = "app_readwrite"
      table_privileges    = ["SELECT", "INSERT", "UPDATE", "DELETE"]
      sequence_privileges = ["USAGE", "SELECT", "UPDATE"]
    }
  }

  users = { for user in var.users : user.name => user }
}
