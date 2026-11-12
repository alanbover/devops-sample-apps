module "rds" {
  source = "../../../../modules/aws-rds"

  identifier         = local.name
  vpc_id             = data.terraform_remote_state.testing_infrastructure.outputs.vpc_id
  private_subnet_ids = values(data.terraform_remote_state.testing_infrastructure.outputs.private_subnet_ids)
  allowed_security_groups = {
    eks = data.aws_eks_cluster.testing.vpc_config[0].cluster_security_group_id
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
