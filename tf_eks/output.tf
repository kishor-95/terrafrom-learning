output "cluster_name" {
    description = "The name of the EKS cluster"
    value       = aws_eks_cluster.eks_cluster.name  
}

output "vpc" {
  description = "The value of vpc"
  value       = aws_vpc.eks_vpc.id
}

output "subnet" {
  description = "The value of the subnetes"
  value = aws_subnet.eks_subnet[*].id
}