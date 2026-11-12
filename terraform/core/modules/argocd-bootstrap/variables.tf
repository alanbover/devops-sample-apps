variable "environment" {
  description = "Environment name used to label the Argo CD cluster and name its root Applications."
  type        = string
}

variable "repository_url" {
  description = "Git URL containing the deployment configuration."
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name used to register the local cluster with Argo CD."
  type        = string
}

variable "aws_region" {
  description = "AWS region of the EKS cluster."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID of the EKS cluster."
  type        = string
}

variable "aws_load_balancer_controller_role_arn" {
  description = "IRSA role ARN for the AWS Load Balancer Controller."
  type        = string
}

variable "target_revision" {
  description = "Git revision Argo CD tracks for the deployment configuration."
  type        = string
}

variable "argocd_chart_version" {
  description = "Pinned version of the Argo CD Helm chart."
  type        = string
}

variable "argocd_apps_chart_version" {
  description = "Pinned version of the Argo CD Apps Helm chart."
  type        = string
}
