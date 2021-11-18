resource "aws_subnet" "primary-app-0" {
  vpc_id                  = aws_vpc.this_vpc.id
  cidr_block              = var.cidr_bloc_0_app
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name                                                   = "${var.projeto}-app-0-${var.env}"
    Terraform                                              = true
    Ambiente                                               = var.env
     
    Projeto                                                = var.projeto
    Requerente                                             = var.requerente
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" =  var.eks_name
    "kubernetes.io/role/internal-elb"                      = "1"
    modalidade                                             = var.modalidade
  }
}

resource "aws_subnet" "primary-app-1" {
  vpc_id                  = aws_vpc.this_vpc.id
  cidr_block              = var.cidr_bloc_1_app
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name                                                   = "${var.projeto}-app-1-${var.env}"
    Terraform                                              = true
    Ambiente                                               = var.env
    APP                                                    = var.app
    Projeto                                                = var.projeto
    Requerente                                             = var.requerente
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" =  var.eks_name
    "kubernetes.io/role/internal-elb"                      = "1"
    modalidade                                             = var.modalidade
  }
}

resource "aws_subnet" "primary-app-2" {
  vpc_id                  = aws_vpc.this_vpc.id
  cidr_block              = var.cidr_bloc_2_app
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[2]

  tags = {
    Name                                                   = "${var.projeto}-app-2-${var.env}"
    Terraform                                              = true
    Ambiente                                               = var.env
    APP                                                    = var.app
    Projeto                                                = var.projeto
    Requerente                                             = var.requerente
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" =  var.eks_name
    "kubernetes.io/role/internal-elb"                      = "1"
    modalidade                                             = var.modalidade
  }
}