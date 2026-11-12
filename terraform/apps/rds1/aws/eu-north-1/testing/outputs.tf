output "address" {
  description = "Private PostgreSQL DNS name."
  value       = module.rds.address
}

output "port" {
  description = "PostgreSQL listener port."
  value       = module.rds.port
}

output "database_name" {
  description = "Initial database name."
  value       = module.rds.database_name
}

output "master_username" {
  description = "RDS master PostgreSQL role name."
  value       = module.rds.master_username
}

output "resource_id" {
  description = "RDS resource ID used in IAM database connect ARNs."
  value       = module.rds.resource_id
}

output "master_secret_arn" {
  description = "ARN of the RDS-managed master password secret."
  value       = module.rds.master_secret_arn
}

output "iam_db_connect_arns" {
  description = "Attach rds-db:connect permission for each enabled user to its intended AWS IAM principal."
  value       = module.postgresql_users.iam_db_connect_arns
}
