provider "aws" {
  region  = var.region
  profile = "tud-admin"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # version = "~> 4.39"
      version = "~> 5.12"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
