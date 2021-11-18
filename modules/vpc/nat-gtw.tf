# nat gw
resource "aws_eip" "this-eip" {
  vpc = true
  tags = {
    Name                                                   = "${var.projeto}-eip-${var.env}"
    Terraform                                              = true
    Ambiente                                               = var.env
     
    Projeto                                                = var.projeto
    Requerente                                             = var.requerente
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" = var.eks_name
    "kubernetes.io/role/internal-elb"                      = "1"
    modalidade                                             = var.modalidade
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "this-nat-gw" {
  allocation_id = aws_eip.this-eip.id
  subnet_id     = aws_subnet.primary-dmz-0.id
  depends_on = [
    aws_internet_gateway.this_igw_vpc
  ]
  tags = {
    Name                                                   = "${var.projeto}-nat-gw-${var.env}"
    Terraform                                              = true
    Ambiente                                               = var.env
     
    Projeto                                                = var.projeto
    Requerente                                             = var.requerente
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" =  var.eks_name
    "kubernetes.io/role/internal-elb"                      = "1"
    modalidade                                             = var.modalidade
  }

  lifecycle {
    create_before_destroy = true
  }
}