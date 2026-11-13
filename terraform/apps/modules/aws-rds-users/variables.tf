variable "database_name" {
  description = "Database whose public schema the users may access."
  type        = string
}

variable "master_username" {
  description = "Role that creates tables and sequences, used for default grants."
  type        = string
}

variable "rds_resource_id" {
  description = "RDS resource ID for IAM database connect ARNs."
  type        = string
}

variable "aws_region" {
  description = "AWS region of the RDS instance."
  type        = string
}

variable "aws_account_id" {
  description = "AWS account that owns the RDS instance."
  type        = string
}

variable "users" {
  description = "PostgreSQL login roles and their readonly or readwrite access."
  type = list(object({
    name    = string
    role    = string
    enabled = optional(bool, true)
  }))

  validation {
    condition = (
      length(var.users) == length(distinct([for user in var.users : user.name])) &&
      alltrue([for user in var.users : contains(["readonly", "readwrite"], user.role)])
    )
    error_message = "User names must be unique and each role must be readonly or readwrite."
  }
}
