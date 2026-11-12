resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_chart_version
  namespace        = local.argocd_namespace
  create_namespace = true
  wait             = true
  timeout          = 600
  values = [yamlencode({
    configs = {
      clusterCredentials = {
        (var.cluster_name) = {
          server = "https://kubernetes.default.svc"
          labels = {
            environment                     = var.environment
            "devops-exercise.io/aws-region" = var.aws_region
            "devops-exercise.io/aws-vpc-id" = var.vpc_id
          }
          annotations = {
            "devops-exercise.io/aws-lbc-role-arn" = var.aws_load_balancer_controller_role_arn
          }
          config = {
            tlsClientConfig = {
              insecure = false
            }
          }
        }
      }
    }
  })]
}

resource "helm_release" "root_application" {
  name       = "argocd-root-application"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = var.argocd_apps_chart_version
  namespace  = local.argocd_namespace
  wait       = true
  timeout    = 600
  values     = [yamlencode(local.root_applications_values)]

  depends_on = [helm_release.argocd]
}
