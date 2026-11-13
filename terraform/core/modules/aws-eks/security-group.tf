resource "aws_vpc_security_group_ingress_rule" "cluster_api" {
  for_each = var.cluster_api_security_group_ids

  security_group_id            = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  referenced_security_group_id = each.value
  description                  = "Kubernetes API from ${each.key}"
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
}
