module "rds" {
  source = "../../../../modules/aws-rds"

  identifier         = local.name
  vpc_id             = data.terraform_remote_state.testing_infrastructure.outputs.vpc_id
  private_subnet_ids = values(data.terraform_remote_state.testing_infrastructure.outputs.private_subnet_ids)
  allowed_security_groups = {
    eks     = data.aws_eks_cluster.testing.vpc_config[0].cluster_security_group_id
    bastion = data.terraform_remote_state.testing_infrastructure.outputs.bastion_security_group_id
  }

  database_name                       = "rds1"
  master_username                     = "appadmin"
  iam_database_authentication_enabled = true
  engine_version                      = "17"
  instance_class                      = "db.t4g.small"
  allocated_storage                   = 20
  backup_retention_period             = 7
  multi_az                            = false
  # This exercise treats the testing database as disposable, so deletion
  # without a final snapshot is acceptable.
  deletion_protection = false
  skip_final_snapshot = true
}

ephemeral "tunnel_ssm" "database" {
  target_host  = module.rds.address
  target_port  = module.rds.port
  ssm_instance = data.terraform_remote_state.testing_infrastructure.outputs.bastion_instance_id
  ssm_region   = "eu-north-1"

  # The RDS instance and the bastion access rule must exist before connecting.
  depends_on = [module.rds]
}

ephemeral "aws_secretsmanager_secret_version" "master" {
  secret_id = module.rds.master_secret_arn
}

module "postgresql_users" {
  source = "../../../../modules/aws-rds-users"

  providers = { postgresql = postgresql }

  database_name   = module.rds.database_name
  master_username = module.rds.master_username
  rds_resource_id = module.rds.resource_id
  aws_region      = local.region
  aws_account_id  = data.aws_caller_identity.current.account_id
  users           = yamldecode(file("${path.module}/users.yaml")).users
}
