resource "aws_iam_role" "cluster" {
  name               = "${var.cluster_name}-cluster"
  assume_role_policy = local.cluster_assume_role_policy

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cluster" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "nodes" {
  name               = "${var.cluster_name}-nodes"
  assume_role_policy = local.node_assume_role_policy

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "nodes" {
  for_each = local.node_policy_arns

  role       = aws_iam_role.nodes.name
  policy_arn = each.value
}
