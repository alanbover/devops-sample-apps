output "vpc_id" {
  description = "ID of the testing VPC."
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block reserved for the testing VPC."
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "Testing public subnet IDs keyed by availability zone."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Testing private subnet IDs keyed by availability zone."
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_id" {
  description = "Testing NAT Gateway ID."
  value       = module.vpc.nat_gateway_id
}

output "nat_eip_public_ip" {
  description = "Single testing VPC egress IP."
  value       = module.vpc.nat_eip_public_ip
}

output "aws_region" {
  description = "Region containing the testing resources."
  value       = "eu-north-1"
}

output "cluster_name" {
  description = "Testing EKS cluster name."
  value       = module.eks.cluster_name
}

output "cluster_arn" {
  description = "Testing EKS cluster ARN."
  value       = module.eks.cluster_arn
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded certificate authority data for the testing EKS API."
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "cluster_endpoint" {
  description = "Testing EKS API endpoint."
  value       = module.eks.cluster_endpoint
}

output "cluster_oidc_issuer_url" {
  description = "Testing EKS cluster OIDC issuer URL."
  value       = module.eks.cluster_oidc_issuer_url
}

output "aws_load_balancer_controller_role_arn" {
  description = "Testing AWS Load Balancer Controller IRSA role ARN."
  value       = module.eks.aws_load_balancer_controller_role_arn
}

