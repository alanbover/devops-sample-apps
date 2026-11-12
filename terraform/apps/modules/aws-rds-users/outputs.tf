output "iam_db_connect_arns" {
  description = "IAM database connect ARN for each enabled PostgreSQL login role."
  value = {
    for username, user in local.users : username =>
    "arn:aws:rds-db:${var.aws_region}:${var.aws_account_id}:dbuser:${var.rds_resource_id}/${username}"
    if user.enabled
  }
}
