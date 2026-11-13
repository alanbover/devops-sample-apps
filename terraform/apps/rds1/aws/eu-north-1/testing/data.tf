data "terraform_remote_state" "testing_infrastructure" {
  backend = "s3"

  config = {
    bucket       = "devops-sample-apps-tfstate-594081136085-eu-north-1"
    key          = "core/aws/eu-north-1/testing/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}

data "aws_eks_cluster" "testing" {
  name = data.terraform_remote_state.testing_infrastructure.outputs.cluster_name
}

data "aws_caller_identity" "current" {}
