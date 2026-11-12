module "vpc" {
  source = "../../../../modules/aws-vpc"

  name                 = local.name
  vpc_cidr             = local.vpc_cidr
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}

module "eks" {
  source = "../../../../modules/aws-eks"

  cluster_name           = local.name
  environment            = local.environment
  kubernetes_version     = local.kubernetes_version
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = values(module.vpc.private_subnet_ids)
  endpoint_public_access = var.operator_public_cidr != null
  public_access_cidrs    = var.operator_public_cidr == null ? [] : [var.operator_public_cidr]

  node_min_size     = 2
  node_desired_size = 3
  node_max_size     = 5
}

