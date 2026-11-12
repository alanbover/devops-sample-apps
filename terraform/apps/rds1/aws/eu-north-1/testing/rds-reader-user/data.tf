data "terraform_remote_state" "rds" {
  backend = "s3"

  config = {
    bucket       = "devops-sample-apps-tfstate-594081136085-eu-north-1"
    key          = "apps/rds1/aws/eu-north-1/testing/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}
