###############################################################################
# Outputs - VPC
###############################################################################
output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.VPC.id
}

output "public_subnet_a_id" {
  description = "The ID of the Public Subnet A."
  value       = aws_subnet.PublicSubnetA.id
}

output "public_subnet_b_id" {
  description = "The ID of the Public Subnet B."
  value       = aws_subnet.PublicSubnetB.id
}

output "public_subnet_c_id" {
  description = "The ID of the Public Subnet C."
  value       = aws_subnet.PublicSubnetC.id
}

output "private_subnet_a_id" {
  description = "The ID of the Private Subnet A."
  value       = aws_subnet.PrivateSubnetA.id
}

output "private_subnet_b_id" {
  description = "The ID of the Private Subnet B."
  value       = aws_subnet.PrivateSubnetB.id
}

output "private_subnet_c_id" {
  description = "The ID of the Private Subnet C."
  value       = aws_subnet.PrivateSubnetC.id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = [aws_subnet.PrivateSubnetA.id, aws_subnet.PrivateSubnetB.id, aws_subnet.PrivateSubnetC.id]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = [aws_subnet.PublicSubnetA.id, aws_subnet.PublicSubnetB.id, aws_subnet.PublicSubnetC.id]
}

output "all_subnets" {
  description = "List of IDs of all subnets"
  value       = [aws_subnet.PublicSubnetA.id, aws_subnet.PublicSubnetB.id, aws_subnet.PublicSubnetC.id, aws_subnet.PrivateSubnetA.id, aws_subnet.PrivateSubnetB.id, aws_subnet.PrivateSubnetC.id]
}
