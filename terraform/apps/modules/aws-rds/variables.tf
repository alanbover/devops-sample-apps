variable "identifier" {
  description = "Unique RDS instance identifier."
  type        = string
}

variable "vpc_id" {
  description = "VPC containing the database."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs in at least two availability zones."
  type        = list(string)
}

variable "allowed_security_groups" {
  description = "Security groups allowed to connect to PostgreSQL, keyed by a stable name."
  type        = map(string)
}

variable "database_name" {
  description = "Initial PostgreSQL database name."
  type        = string
}

variable "master_username" {
  description = "PostgreSQL master username. RDS manages its password in Secrets Manager."
  type        = string
}

variable "iam_database_authentication_enabled" {
  description = "Whether PostgreSQL accepts IAM database authentication."
  type        = bool
  default     = false
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
}

variable "engine_version" {
  description = "PostgreSQL engine major version."
  type        = string
}

variable "allocated_storage" {
  description = "Initial storage capacity in GiB."
  type        = number
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups."
  type        = number
}

variable "multi_az" {
  description = "Whether to provision a standby in another availability zone."
  type        = bool
}

variable "deletion_protection" {
  description = "Whether to prevent RDS instance deletion."
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Whether to skip a final snapshot when destroying the database."
  type        = bool
}
