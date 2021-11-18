
# Internet GW
resource "aws_internet_gateway" "this_igw_vpc" {
  vpc_id = aws_vpc.this_vpc.id

  tags = {
    Name                                                   = "${var.projeto}-igw-${var.env}"
    Terraform                                              = true
    Ambiente                                               = var.env
     
    Projeto                                                = var.projeto
    Requerente                                             = var.requerente
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" =  var.eks_name
    "kubernetes.io/role/internal-elb"                      = "1"
    modalidade                                             = var.modalidade
  }
}