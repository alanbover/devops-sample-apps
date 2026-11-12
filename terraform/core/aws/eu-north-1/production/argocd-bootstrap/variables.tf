variable "argocd_chart_version" {
  description = "Pinned version of the Argo CD Helm chart."
  type        = string
  default     = "10.17.1"
}

variable "argocd_apps_chart_version" {
  description = "Pinned version of the Argo CD Apps Helm chart."
  type        = string
  default     = "2.0.8"
}
