variable "operator_public_cidr" {
  description = "Optional single public IPv4 address (/32) allowed to access the EKS API during bootstrap. Leave null for private-only access."
  type        = string
  default     = null

  validation {
    condition = var.operator_public_cidr == null ? true : (
      can(regex("^[0-9.]+/32$", var.operator_public_cidr)) &&
      can(cidrhost(var.operator_public_cidr, 0)) &&
      var.operator_public_cidr != "0.0.0.0/32"
    )
    error_message = "operator_public_cidr must be a single valid public IPv4 /32 address, or null."
  }
}
