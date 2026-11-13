output "instance_id" {
  description = "SSM-managed EC2 instance ID."
  value       = aws_instance.bastion.id
}

output "security_group_id" {
  description = "Security group to authorize access to private destinations."
  value       = aws_security_group.bastion.id
}
