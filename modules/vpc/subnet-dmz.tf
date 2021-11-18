resource "aws_subnet" "primary-dmz-0" {
  vpc_id                  = aws_vpc.this_vpc.id
  cidr_block              = var.cidr_bloc_0_dmz
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name                                                   = "${var.projeto}-dmz-0-${var.env}"
    Terraform                                              = true
    Ambiente                                               = var.env
     
    Projeto                                                = var.projeto
    Requerente                                             = var.requerente
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" =  var.eks_name
    "kubernetes.io/role/internal-elb"                      = "1"
    modalidade                                             = var.modalidade
  }
}

resource "aws_subnet" "primary-dmz-1" {
  vpc_id                  = aws_vpc.this_vpc.id
  cidr_block              = var.cidr_bloc_1_dmz
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name                                                   = "${var.projeto}-dmz-1-${var.env}"
    Terraform                                              = true
    Ambiente                                               = var.env
     
    Projeto                                                = var.projeto
    Requerente                                             = var.requerente
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" =  var.eks_name
    "kubernetes.io/role/internal-elb"                      = "1"
    modalidade                                             = var.modalidade
  }
}

resource "aws_subnet" "primary-dmz-2" {
  vpc_id                  = aws_vpc.this_vpc.id
  cidr_block              = var.cidr_bloc_2_dmz
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[2]

  tags = {
    Name                                                   = "${var.projeto}-dmz-2-${var.env}"
    Terraform                                              = true
    Ambiente                                               = var.env
     
    Projeto                                                = var.projeto
    Requerente                                             = var.requerente
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" =  var.eks_name
    "kubernetes.io/role/internal-elb"                      = "1"
    modalidade                                             = var.modalidade
  }
}