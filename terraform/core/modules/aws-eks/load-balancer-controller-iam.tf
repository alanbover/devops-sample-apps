resource "aws_iam_openid_connect_provider" "cluster" {
  url             = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cluster_oidc.certificates[length(data.tls_certificate.cluster_oidc.certificates) - 1].sha1_fingerprint]

  tags = local.tags
}

# Policy document follows the controller's official v3.6.2 policy:
# https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v3.6.2/docs/install/iam_policy.json
resource "aws_iam_policy" "load_balancer_controller" {
  name        = "aws-lbc-${var.environment}-${substr(sha1("${var.cluster_name}-${data.aws_region.current.region}"), 0, 8)}"
  description = "Permissions for AWS Load Balancer Controller v3.6.2 in ${var.cluster_name}."
  policy      = replace(file("${path.module}/policies/aws-load-balancer-controller-v3.6.2.json"), "arn:aws:", "arn:${data.aws_partition.current.partition}:")

  tags = local.tags
}

resource "aws_iam_role" "load_balancer_controller" {
  name               = "aws-lbc-${var.environment}-${substr(sha1("${var.cluster_name}-${data.aws_region.current.region}"), 0, 8)}"
  assume_role_policy = local.load_balancer_controller_assume_role_policy

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "load_balancer_controller" {
  role       = aws_iam_role.load_balancer_controller.name
  policy_arn = aws_iam_policy.load_balancer_controller.arn
}
