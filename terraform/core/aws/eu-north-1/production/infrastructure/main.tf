module "vpc" {
  source = "../../../../modules/aws-vpc"

  name                 = local.name
  vpc_cidr             = local.vpc_cidr
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}

module "bastion" {
  source = "../../../../modules/aws-bastion"

  name              = "${local.name}-bastion"
  vpc_id            = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_ids[sort(keys(local.private_subnet_cidrs))[0]]

  # Wait for the VPC's private routes and NAT gateway before starting SSM Agent.
  depends_on = [module.vpc]
}

module "eks" {
  source = "../../../../modules/aws-eks"

  cluster_name                   = local.name
  environment                    = local.environment
  kubernetes_version             = local.kubernetes_version
  vpc_id                         = module.vpc.vpc_id
  private_subnet_ids             = values(module.vpc.private_subnet_ids)
  cluster_api_security_group_ids = [module.bastion.security_group_id]
  endpoint_public_access         = var.operator_public_cidr != null
  public_access_cidrs            = var.operator_public_cidr == null ? [] : [var.operator_public_cidr]

  node_min_size     = 2
  node_desired_size = 3
  node_max_size     = 5
}

