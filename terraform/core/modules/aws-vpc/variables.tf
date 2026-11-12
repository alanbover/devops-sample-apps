variable "name" {
  description = "Name prefix used for VPC resources."
  type        = string
}

variable "vpc_cidr" {
  description = "Non-overlapping IPv4 CIDR reserved for this environment's VPC."
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid IPv4 CIDR block."
  }
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR by availability zone. At least two are required; the first sorted zone hosts the single NAT gateway."
  type        = map(string)

  validation {
    condition = (
      length(var.public_subnet_cidrs) >= 2 &&
      alltrue([for cidr in values(var.public_subnet_cidrs) : can(cidrhost(cidr, 0))])
    )
    error_message = "Provide valid public subnet CIDRs in at least two availability zones."
  }
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR by availability zone. Use the same availability zones as the public subnet map."
  type        = map(string)

  validation {
    condition = (
      length(var.private_subnet_cidrs) >= 2 &&
      toset(keys(var.private_subnet_cidrs)) == toset(keys(var.public_subnet_cidrs)) &&
      alltrue([for cidr in values(var.private_subnet_cidrs) : can(cidrhost(cidr, 0))])
    )
    error_message = "Provide valid private subnet CIDRs for the same at least two availability zones used by the public subnet map."
  }
}

variable "tags" {
  description = "Additional tags applied to the VPC resources."
  type        = map(string)
  default     = {}
}
