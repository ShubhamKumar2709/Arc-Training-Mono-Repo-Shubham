output "vpc_id" {
  value = aws_vpc.stage-vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.publicsubnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.privatesubnet[*].id
}

output "public_route_table_id" {
  value = aws_route_table.publicroute.id
}

output "private_route_table_id" {
  value = aws_route_table.privateroute.id
}
