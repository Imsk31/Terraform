provider "aws" {
  region     = var.region
  profile = "tf-project"
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }
  }
}
