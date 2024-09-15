terraform {
  backend "s3" {
    bucket = "582024"
    key    = "terrform-project/terraform.tfstate"
    region = "us-east-1"
  }
}
