data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_subnet" "private" {
  for_each = {
    for index, subnet_id in var.private_subnet_ids : tostring(index) => subnet_id
  }
  id = each.value
}

data "tls_certificate" "cluster_oidc" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}
