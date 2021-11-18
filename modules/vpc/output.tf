output "vpc-sa-east" {
  value = [
    data.aws_availability_zones.available,
    aws_vpc.this_vpc.id,
    aws_subnet.primary-dmz-0.id,
    aws_subnet.primary-dmz-1.id,
    aws_subnet.primary-dmz-2.id,
    aws_subnet.primary-app-0.id,
    aws_subnet.primary-app-1.id,
    aws_subnet.primary-app-2.id,
    aws_route_table.this-route-dmz.id,
    aws_route_table_association.this-route-dmz-0.id,
    aws_route_table_association.this-route-dmz-1.id,
    aws_route_table_association.this-route-dmz-2.id,
    aws_route_table.route-app.id,
    aws_route_table_association.this-route-app-0.id,
    aws_route_table_association.this-route-app-1.id,
    aws_route_table_association.this-route-app-2.id,
    aws_eip.this-eip.id,
    aws_nat_gateway.this-nat-gw.id,
    aws_internet_gateway.this_igw_vpc.id
  ]
}