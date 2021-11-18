resource "aws_route_table" "route-app" {
  vpc_id = aws_vpc.this_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this-nat-gw.id
  }

  tags = {
    Name                                                   = "${var.projeto}-route-app-${var.env}"
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

# route associations private
resource "aws_route_table_association" "this-route-app-0" {
  subnet_id      = aws_subnet.primary-app-0.id
  route_table_id = aws_route_table.route-app.id
}

resource "aws_route_table_association" "this-route-app-1" {
  subnet_id      = aws_subnet.primary-app-1.id
  route_table_id = aws_route_table.route-app.id
}

resource "aws_route_table_association" "this-route-app-2" {
  subnet_id      = aws_subnet.primary-app-2.id
  route_table_id = aws_route_table.route-app.id
}

