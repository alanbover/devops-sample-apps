locals {
  project     = "devops-exercise"
  environment = "testing"
  region      = "eu-north-1"
  name        = "${local.project}-${local.environment}-${local.region}-rds1"
}
