output "identifier" {
  description = "RDS instance identifier."
  value       = aws_db_instance.database.identifier
}

output "resource_id" {
  description = "RDS resource ID used in IAM database connect ARNs."
  value       = aws_db_instance.database.resource_id
}

output "address" {
  description = "Private RDS DNS name."
  value       = aws_db_instance.database.address
}

output "port" {
  description = "PostgreSQL listener port."
  value       = aws_db_instance.database.port
}

output "database_name" {
  description = "Initial database name."
  value       = aws_db_instance.database.db_name
}

output "master_username" {
  description = "RDS master PostgreSQL role name."
  value       = aws_db_instance.database.username
}

output "master_secret_arn" {
  description = "ARN of the RDS-managed master password secret."
  value       = aws_db_instance.database.master_user_secret[0].secret_arn
}

output "security_group_id" {
  description = "Security group attached to the RDS instance."
  value       = aws_security_group.database.id
}
