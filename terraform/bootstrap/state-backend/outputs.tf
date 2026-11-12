output "state_bucket_name" {
  description = "S3 bucket name to use in Terraform S3 backend configuration."
  value       = aws_s3_bucket.terraform_state.id
}

output "state_bucket_arn" {
  description = "S3 bucket ARN for IAM policies that grant Terraform state access."
  value       = aws_s3_bucket.terraform_state.arn
}

output "state_bucket_region" {
  description = "AWS region that contains the S3 state bucket."
  value       = var.aws_region
}
