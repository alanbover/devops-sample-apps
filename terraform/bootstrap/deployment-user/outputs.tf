output "deployment_user_name" {
  description = "Name of the Terraform deployment user."
  value       = aws_iam_user.deployment.name
}

output "deployment_user_arn" {
  description = "ARN of the Terraform deployment user."
  value       = aws_iam_user.deployment.arn
}

output "deployment_policy_arn" {
  description = "ARN of the managed deployment policy."
  value       = aws_iam_policy.deployment.arn
}
