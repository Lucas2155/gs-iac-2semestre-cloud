terraform {
  backend "s3" {
    bucket  = "iac-fc-team"
    encrypt = true
    key     = "openfinance/sandbox/eks"
    region  = "us-east-1"
  }
}