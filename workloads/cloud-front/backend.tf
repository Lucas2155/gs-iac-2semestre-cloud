terraform {
  backend "s3" {
    bucket  = "cloudit-fiap-iac"
    encrypt = true
    key     = "cloudit-fiap-iac/GS/cloud-front"
    region  = "us-east-1"
  }
}