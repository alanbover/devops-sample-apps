terraform {
  required_version = ">= 1.17.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.72.0, < 7.0.0"
    }
  }

  backend "s3" {
    bucket       = "devops-sample-apps-tfstate-594081136085-eu-north-1"
    key          = "bootstrap/deployment-user/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "devops-sample-apps"
      ManagedBy = "Terraform"
      Purpose   = "Terraform deployment user"
    }
  }
}
