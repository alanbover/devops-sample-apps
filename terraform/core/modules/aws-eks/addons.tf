resource "aws_eks_addon" "addons" {
  for_each = var.cluster_addon_versions

  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = each.key
  addon_version               = each.value
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  tags = local.tags

  depends_on = [aws_eks_node_group.workers]
}
