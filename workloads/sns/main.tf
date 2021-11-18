provider "aws" {
    region =  "us-east-1"
  
}

module sns_this {
    source = "../../modules/sns/"
    name_sns = "testesns"
    tags = {
    Name                                                   = "gs-vpc-sandbox"
    Terraform                                              = true
    APP                                                    = "gs-vpc"
    Projeto                                                = "gs-vpc"
    Requerente                                             = "gs-vpc"
    Ambiente                                               = "sandbox"
    "kubernetes.io/cluster/gs-vpc-sandbox" = "gs-vpc"
    }
}

output "sns" {
  value = [module.sns_this.aws_sns_topic]
}