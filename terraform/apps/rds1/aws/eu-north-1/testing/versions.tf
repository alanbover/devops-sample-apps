terraform {
  required_version = ">= 1.17.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.72.0, < 7.0.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = ">= 1.27.0, < 2.0.0"
    }
    tunnel = {
      source  = "dfns/tunnel"
      version = ">= 1.9.6, < 2.0.0"
    }
  }

  backend "s3" {
    bucket       = "devops-sample-apps-tfstate-594081136085-eu-north-1"
    key          = "apps/rds1/aws/eu-north-1/testing/terraform.tfstate"
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
      Application = "rds1"
    }
  }
}

ephemeral "tunnel_ssm" "database" {
  target_host  = module.rds.address
  target_port  = module.rds.port
  ssm_instance = data.terraform_remote_state.testing_infrastructure.outputs.bastion_instance_id
  ssm_region   = "eu-north-1"

  # The RDS instance and the bastion access rule must exist before connecting.
  depends_on = [module.rds]
}

ephemeral "aws_secretsmanager_secret_version" "master" {
  secret_id = module.rds.master_secret_arn
}

provider "postgresql" {
  host            = ephemeral.tunnel_ssm.database.local_host
  port            = ephemeral.tunnel_ssm.database.local_port
  database        = module.rds.database_name
  username        = module.rds.master_username
  password        = jsondecode(ephemeral.aws_secretsmanager_secret_version.master.secret_string).password
  superuser       = false
  sslmode         = "verify-ca"
  sslrootcert     = "${path.module}/rds-eu-north-1-bundle.pem"
  connect_timeout = 15
}
