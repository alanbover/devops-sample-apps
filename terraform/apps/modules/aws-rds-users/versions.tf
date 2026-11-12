terraform {
  required_version = ">= 1.17.1"

  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = ">= 1.27.0, < 2.0.0"
    }
  }
}
