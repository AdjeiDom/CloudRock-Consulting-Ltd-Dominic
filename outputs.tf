
output "aws_vpc_id" {
  value = "${aws_vpc.Prod-rock-VPC.id}"
}

output "aws_vpc_cidr_block" {
  value = "${aws_vpc.Prod-rock-VPC.cidr_block}"
}

output "aws_subnet_public-sub1_id" {
  value = "${aws_subnet.Test-public-sub1.id}"
}

output "aws_subnet_public-sub2_id" {
  value = "${aws_subnet.test-public-sub2.id}"
}

output "aws_subnet_private_subnet_1" {
  value = "${aws_subnet.Test-priv-sub1.id}"
}

output "aws_subnet_private_subnet_2" {
  value = "${aws_subnet.Test-priv-sub2.id}"
}

output "aws_route_table_public_route-table" {
  value = "${aws_route_table.Test-pub-route-table.id}"
}

output "aws_route_table_private_route-table" {
  value = "${aws_route_table.Test-priv-route-table.id}"
}

output "aws_internet_gateway_Test_igw_id" {
  value = "${aws_internet_gateway.Test-igw.id}"
}

output "aws_route_igw_association_public-rtb" {
  value = "${aws_route.Test-igw-association.id}"
}

output "aws_nat_gateway_public_NAT_gateway_id" {
  value = "${aws_nat_gateway.Test-Nat-gateway.id}"
}

output "aws_route_NAT_association_priv-rtb" {
  value = "${aws_route.test-Nat-association.id}"
}

output "aws_sec_group_id" {
  value = "${aws_security_group.Test-sec-group.id}"
}

output "aws_instance_pub_id" {
  value = "${aws_instance.Test-serve-1.id}"
}

output "aws_instance_pub_ip_address" {
  value = "${aws_instance.Test-serve-1.public_ip}"
}


output "aws_instance_private_id" {
  value = "${aws_instance.Test-serve-2.id}"
}

output "aws_instance_priv_ip_address" {
  value = "${aws_instance.Test-serve-2.private_ip}"
}