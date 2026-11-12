module "argocd_bootstrap" {
  source = "../../../../modules/argocd-bootstrap"

  environment                           = "production"
  repository_url                        = "https://github.com/alanbover/devops-sample-apps.git"
  cluster_name                          = data.terraform_remote_state.infrastructure.outputs.cluster_name
  aws_region                            = data.terraform_remote_state.infrastructure.outputs.aws_region
  vpc_id                                = data.terraform_remote_state.infrastructure.outputs.vpc_id
  aws_load_balancer_controller_role_arn = data.terraform_remote_state.infrastructure.outputs.aws_load_balancer_controller_role_arn
  target_revision                       = "master"
  argocd_chart_version                  = var.argocd_chart_version
  argocd_apps_chart_version             = var.argocd_apps_chart_version
}
