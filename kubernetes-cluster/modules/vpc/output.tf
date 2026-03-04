output "vpc_id" {
  value = aws_vpc.eks_vpc
}

output "Public-subnets" {
  value =  aws_subnet.eks_public_subnet
}

output "Private-subnets" {
  value = aws_subnet.private-subnet
}

output "Nat-IP" {
  value = aws_nat_gateway.eks_nat_gateway
}

output "EIP" {
  value = aws_eip.eks_nat_gateway_eip
}