# Internet VPC
resource "aws_vpc" "this_vpc" {
  cidr_block           = var.cidr_vpc
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_classiclink   = var.enable_classiclink
  tags = {
    Name                                                   = var.name_vpc
    Terraform                                              = true
    Ambiente                                               = var.env
     
    Projeto                                                = var.projeto
    Requerente                                             = var.requerente
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" = var.eks_name
    "kubernetes.io/role/internal-elb"                      = "1"
    modalidade                                             = var.modalidade
  }
}
