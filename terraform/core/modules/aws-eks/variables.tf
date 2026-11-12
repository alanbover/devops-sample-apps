variable "cluster_name" {
  description = "Name of the EKS cluster and its IAM roles."
  type        = string
}

variable "environment" {
  description = "Environment label applied to every resource created by the module."
  type        = string

  validation {
    condition     = contains(["testing", "production"], var.environment)
    error_message = "environment must be either testing or production."
  }
}

variable "kubernetes_version" {
  description = "Explicit Kubernetes version for the EKS control plane."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the EKS control plane and managed nodes."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "EKS requires private subnets in at least two availability zones."
  }
}

variable "vpc_id" {
  description = "VPC ID containing the private subnets and EKS cluster."
  type        = string

  validation {
    condition     = can(regex("^vpc-[0-9a-f]+$", var.vpc_id))
    error_message = "vpc_id must be an AWS VPC ID."
  }
}

variable "endpoint_public_access" {
  description = "Whether to enable the EKS public API endpoint. The private endpoint remains enabled."
  type        = bool
  default     = false
}

variable "public_access_cidrs" {
  description = "Trusted IPv4 CIDRs allowed to reach the public EKS API endpoint when enabled."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for cidr in var.public_access_cidrs : can(cidrhost(cidr, 0))
    ])
    error_message = "Every public_access_cidrs entry must be a valid IPv4 CIDR block."
  }
}

variable "bootstrap_cluster_creator_admin_permissions" {
  description = "Grant the identity creating the cluster initial cluster-admin access."
  type        = bool
  default     = true
}

variable "enabled_cluster_log_types" {
  description = "EKS control-plane log types to publish to CloudWatch Logs."
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "node_instance_types" {
  description = "EC2 instance types used by the managed node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_capacity_type" {
  description = "Managed node group capacity type."
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.node_capacity_type)
    error_message = "node_capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "node_disk_size_gib" {
  description = "Root volume size for each managed worker node, in GiB."
  type        = number
  default     = 30

  validation {
    condition     = var.node_disk_size_gib >= 20
    error_message = "node_disk_size_gib must be at least 20 GiB."
  }
}

variable "node_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 1
}

variable "node_desired_size" {
  description = "Initial desired number of worker nodes."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 3
}

variable "node_max_unavailable" {
  description = "Maximum number of nodes unavailable during a managed node group update."
  type        = number
  default     = 1
}

variable "cluster_addon_versions" {
  description = "Map of EKS add-on names to explicitly pinned versions, for example vpc-cni => vX.Y.Z-eksbuild.N."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Additional tags applied to EKS and IAM resources. Shared Project, Environment, and ManagedBy tags come from the caller's AWS provider default_tags."
  type        = map(string)
  default     = {}
}
