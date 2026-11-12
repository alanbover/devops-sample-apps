terraform {
  required_version = ">= 1.17.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.72.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "devops-sample-apps"
      ManagedBy = "Terraform"
      Purpose   = "Terraform state storage"
    }
  }
}

terraform {
  backend "s3" {
    bucket       = "devops-sample-apps-tfstate-594081136085-eu-north-1"
    key          = "bootstrap/state-backend/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}
