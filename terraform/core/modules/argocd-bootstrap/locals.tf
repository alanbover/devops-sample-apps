locals {
  argocd_namespace       = "argocd"
  apps_application       = "devops-sample-apps-${var.environment}-apps"
  platform_application   = "devops-sample-apps-${var.environment}-platform"

  root_applications_values = {
    applications = {
      (local.apps_application) = {
        namespace = local.argocd_namespace
        project   = "default"
        source = {
          repoURL        = var.repository_url
          targetRevision = var.target_revision
          path           = "deployment/apps"
          directory = {
            include = "applicationset.yaml"
          }
        }
        destination = {
          server    = "https://kubernetes.default.svc"
          namespace = local.argocd_namespace
        }
        syncPolicy = {
          automated = {
            prune    = true
            selfHeal = true
          }
        }
      }
      (local.platform_application) = {
        namespace = local.argocd_namespace
        project   = "default"
        source = {
          repoURL        = var.repository_url
          targetRevision = var.target_revision
          path           = "deployment/platform"
          directory = {
            include = "applicationset.yaml"
          }
        }
        destination = {
          server    = "https://kubernetes.default.svc"
          namespace = local.argocd_namespace
        }
        syncPolicy = {
          automated = {
            prune    = true
            selfHeal = true
          }
        }
      }
    }
  }
}
