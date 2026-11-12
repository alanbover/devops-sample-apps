output "namespace" {
  description = "Kubernetes namespace containing the Argo CD installation."
  value       = helm_release.argocd.namespace
}

output "chart_version" {
  description = "Installed Argo CD Helm chart version."
  value       = helm_release.argocd.version
}

output "apps_application_name" {
  description = "Argo CD Application that tracks the sample app ApplicationSet."
  value       = local.apps_application
}

output "platform_application_name" {
  description = "Argo CD Application that tracks the platform ApplicationSets."
  value       = local.platform_application
}
