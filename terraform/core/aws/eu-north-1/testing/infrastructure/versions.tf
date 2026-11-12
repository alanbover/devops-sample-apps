terraform {
  required_version = ">= 1.17.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.72.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
  }

  backend "s3" {
    bucket       = "devops-sample-apps-tfstate-594081136085-eu-north-1"
    key          = "core/aws/eu-north-1/testing/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}
provider "aws" {
  region = "eu-north-1"

  default_tags {
    tags = {
      Project     = "devops-exercise"
      Environment = "testing"
      ManagedBy   = "Terraform"
    }
  }
}
