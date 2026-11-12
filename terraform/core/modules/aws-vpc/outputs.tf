output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.vpc.id
}

output "vpc_cidr" {
  description = "IPv4 CIDR block of the VPC."
  value       = aws_vpc.vpc.cidr_block
}

output "public_subnet_ids" {
  description = "Public subnet IDs keyed by availability zone."
  value       = { for az, subnet in aws_subnet.public : az => subnet.id }
}

output "private_subnet_ids" {
  description = "Private subnet IDs keyed by availability zone."
  value       = { for az, subnet in aws_subnet.private : az => subnet.id }
}

output "nat_gateway_id" {
  description = "ID of the single NAT gateway used by all private subnets."
  value       = aws_nat_gateway.nat.id
}

output "nat_eip_public_ip" {
  description = "Single public egress IP used by routes from all private subnets."
  value       = aws_eip.nat.public_ip
}
