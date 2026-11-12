locals {
  project            = "devops-exercise"
  environment        = "production"
  region             = "eu-north-1"
  name               = "${local.project}-${local.environment}-${local.region}"
  vpc_cidr           = "10.20.16.0/20"
  kubernetes_version = "1.37"
  # Public /26s provide ALB address headroom; /22s give the private node
  # subnets substantially more capacity.
  public_subnet_cidrs = {
    "eu-north-1a" = "10.20.16.0/26"
    "eu-north-1b" = "10.20.31.192/26"
  }
  private_subnet_cidrs = {
    "eu-north-1a" = "10.20.20.0/22"
    "eu-north-1b" = "10.20.24.0/22"
  }
}
