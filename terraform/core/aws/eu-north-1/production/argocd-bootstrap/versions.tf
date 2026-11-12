terraform {
  required_version = ">= 1.17.1"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.3.0"
    }
  }

  backend "s3" {
    bucket       = "devops-sample-apps-tfstate-594081136085-eu-north-1"
    key          = "core/aws/eu-north-1/production/argocd-bootstrap/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}

data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config = {
    bucket = "devops-sample-apps-tfstate-594081136085-eu-north-1"
    key    = "core/aws/eu-north-1/production/terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "helm" {
  kubernetes = {
    host                   = data.terraform_remote_state.infrastructure.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.infrastructure.outputs.cluster_certificate_authority_data)

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        data.terraform_remote_state.infrastructure.outputs.cluster_name,
        "--region",
        data.terraform_remote_state.infrastructure.outputs.aws_region,
      ]
    }
  }
}
