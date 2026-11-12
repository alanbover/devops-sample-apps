output "user_name" {
  description = "IAM user to authenticate as the reader-user PostgreSQL login."
  value       = aws_iam_user.reader.name
}

output "reader_user_db_connect_arn" {
  description = "RDS IAM database user ARN granted to this IAM user."
  value       = data.terraform_remote_state.rds.outputs.iam_db_connect_arns["reader-user"]
}
