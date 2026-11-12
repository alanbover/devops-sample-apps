output "cluster_name" {
  description = "EKS cluster name."
  value       = aws_eks_cluster.cluster.name
}

output "cluster_arn" {
  description = "EKS cluster ARN."
  value       = aws_eks_cluster.cluster.arn
}

output "cluster_endpoint" {
  description = "EKS Kubernetes API endpoint."
  value       = aws_eks_cluster.cluster.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded cluster certificate authority data."
  value       = aws_eks_cluster.cluster.certificate_authority[0].data
  sensitive   = true
}

output "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL used by the EKS workload IAM roles."
  value       = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

output "vpc_id" {
  description = "VPC ID containing the EKS cluster."
  value       = var.vpc_id
}

output "aws_region" {
  description = "AWS region containing the EKS cluster."
  value       = data.aws_region.current.region
}

output "aws_load_balancer_controller_role_arn" {
  description = "IAM role ARN for the AWS Load Balancer Controller service account."
  value       = aws_iam_role.load_balancer_controller.arn
}

output "aws_load_balancer_controller_policy_arn" {
  description = "IAM policy ARN attached to the AWS Load Balancer Controller role."
  value       = aws_iam_policy.load_balancer_controller.arn
}

output "node_group_arn" {
  description = "ARN of the managed worker node group."
  value       = aws_eks_node_group.workers.arn
}

output "cluster_role_arn" {
  description = "IAM role ARN used by the EKS control plane."
  value       = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  description = "IAM role ARN used by managed worker nodes."
  value       = aws_iam_role.nodes.arn
}
