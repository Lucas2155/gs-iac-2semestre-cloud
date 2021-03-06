module gs-vpc {
  source = "../../modules/vpc/"
  env = "sandbox"
  app = "gs-vpc"
  projeto = "gs-vpc"
  requerente = "gs-vpc"
  eks_name = "gs-vpc"
  modalidade = "gs-vpc"
  name_vpc = "gs-vpc"
  cidr_vpc = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  enable_classiclink = false
  cidr_bloc_0_dmz = "10.0.0.0/24"
  cidr_bloc_1_dmz = "10.0.1.0/24"
  cidr_bloc_2_dmz = "10.0.2.0/24"
  cidr_bloc_0_app = "10.0.3.0/24"
  cidr_bloc_1_app = "10.0.4.0/24"
  cidr_bloc_2_app = "10.0.5.0/24"
  cluster-name = "gs-vpc"
}