output "argocd_namespace" {
  description = "Namespace where self-managed Argo CD is installed."
  value       = module.argocd_bootstrap.namespace
}

output "argocd_apps_application_name" {
  description = "Root Application tracking the sample app ApplicationSet."
  value       = module.argocd_bootstrap.apps_application_name
}

output "argocd_platform_application_name" {
  description = "Root Application tracking the platform ApplicationSets."
  value       = module.argocd_bootstrap.platform_application_name
}
