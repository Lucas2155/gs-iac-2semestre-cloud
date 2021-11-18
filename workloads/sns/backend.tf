terraform {
  backend "s3" {
    bucket  = "cloudit-fiap-iac"
    encrypt = true
    key     = "cloudit-fiap-iac/GS/SNS"
    region  = "us-east-1"
  }
}