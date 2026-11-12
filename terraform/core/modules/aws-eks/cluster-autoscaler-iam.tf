resource "aws_iam_policy" "cluster_autoscaler" {
  name        = "aws-ca-${var.environment}-${substr(sha1("${var.cluster_name}-${data.aws_region.current.region}"), 0, 8)}"
  description = "Cluster Autoscaler permissions for ${var.cluster_name}."
  policy      = local.cluster_autoscaler_policy

  tags = local.tags
}

resource "aws_iam_role" "cluster_autoscaler" {
  name               = "aws-ca-${var.environment}-${substr(sha1("${var.cluster_name}-${data.aws_region.current.region}"), 0, 8)}"
  assume_role_policy = local.cluster_autoscaler_assume_role_policy

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
  role       = aws_iam_role.cluster_autoscaler.name
  policy_arn = aws_iam_policy.cluster_autoscaler.arn
}
