resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.kubernetes_version

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = var.bootstrap_cluster_creator_admin_permissions
  }

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.endpoint_public_access ? var.public_access_cidrs : null
  }

  enabled_cluster_log_types = var.enabled_cluster_log_types

  tags = local.tags

  lifecycle {
    precondition {
      condition     = local.private_subnet_vpc_ids == toset([var.vpc_id])
      error_message = "All private_subnet_ids must belong to vpc_id."
    }

    precondition {
      condition     = !var.endpoint_public_access || length(var.public_access_cidrs) > 0
      error_message = "Set at least one trusted public_access_cidrs value when enabling the public EKS endpoint."
    }
  }

  depends_on = [aws_iam_role_policy_attachment.cluster]
}
