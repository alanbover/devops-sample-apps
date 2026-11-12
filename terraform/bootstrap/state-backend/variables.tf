variable "aws_region" {
  description = "Region where the Terraform state bucket is created."
  type        = string
  default     = "eu-north-1"
}

variable "state_bucket_name" {
  description = "Globally unique name for the S3 bucket that stores Terraform state."
  type        = string

  validation {
    condition = (
      length(var.state_bucket_name) >= 3 &&
      length(var.state_bucket_name) <= 63 &&
      can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.state_bucket_name))
    )
    error_message = "The bucket name must be 3-63 characters, use lowercase letters, numbers, periods, or hyphens, and start and end with a letter or number."
  }
  
  default = "devops-sample-apps-tfstate-594081136085-eu-north-1"
}
