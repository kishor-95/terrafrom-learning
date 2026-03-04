variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
}

variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
}

variable "eks_private_subnet_cidr_blocks" {
    description = "List of CIDR blocks for private subnets"
    type        = list(string)
}

variable "environment" {
    description = "The environment for the resources (e.g., dev, staging, prod)"
    type        = string
}

variable "eks_public_subnet_count" {
    description = "Number of public subnets"
    type        = number 
}

variable "eks_private_subnet_count" {
    description = "Number of private subnets"
    type        = number 
}

variable "eks_public_subnet" {
    description = "List of CIDR blocks for public subnets"
    type        = list(string) 
}
