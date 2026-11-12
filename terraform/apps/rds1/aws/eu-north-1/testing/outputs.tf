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

output "master_secret_arn" {
  description = "ARN of the RDS-managed master password secret."
  value       = module.rds.master_secret_arn
}
