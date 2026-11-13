terraform {
  required_version = ">= 1.17.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.72.0, < 7.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.3.0"
    }
    tunnel = {
      source  = "dfns/tunnel"
      version = ">= 1.9.6, < 2.0.0"
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
    bucket       = "devops-sample-apps-tfstate-594081136085-eu-north-1"
    key          = "core/aws/eu-north-1/production/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}

ephemeral "tunnel_ssm" "cluster" {
  target_host  = trimprefix(data.terraform_remote_state.infrastructure.outputs.cluster_endpoint, "https://")
  target_port  = 443
  ssm_instance = data.terraform_remote_state.infrastructure.outputs.bastion_instance_id
  ssm_region   = data.terraform_remote_state.infrastructure.outputs.aws_region
}

provider "helm" {
  kubernetes = {
    # The API certificate is issued for the EKS endpoint, not localhost. The
    # SSM tunnel encrypts the transport, but the forwarded localhost
    # endpoint cannot be validated against the EKS certificate hostname.
    host     = "https://${ephemeral.tunnel_ssm.cluster.local_host}:${ephemeral.tunnel_ssm.cluster.local_port}"
    insecure = true

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
