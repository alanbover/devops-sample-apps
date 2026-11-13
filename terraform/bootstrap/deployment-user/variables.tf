variable "aws_region" {
  description = "AWS region used by the provider. IAM is global, but the provider requires a region."
  type        = string
  default     = "eu-north-1"
}
