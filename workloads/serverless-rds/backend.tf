terraform {
  backend "s3" {
    bucket  = "cloudit-fiap-iac"
    encrypt = true
    key     = "cloudit-fiap-iac/GS/rds-serverless"
    region  = "us-east-1"
  }
}