locals {
    cluster_name = var.cluster_name
}

## VPC Creation
resource "aws_vpc" "eks_vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true



    tags = {
        Name = "${local.cluster_name}-vpc"
        Environment = var.environment
    }
}

## Internet Gateway Creation

resource "aws_internet_gateway" "eks_igw" {

    vpc_id = aws_vpc.eks_vpc.id

    tags = {
        Name = "${local.cluster_name}-igw"
        Environment = var.environment
        "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    }
    depends_on = [ aws_vpc.eks_vpc ]
}

## Public Subnet Creation
resource "aws_subnet" "eks_public_subnet" {
    count = var.eks_public_subnet_count
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = element(var.eks_public_subnet, count.index)
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    map_public_ip_on_launch = true

    tags = {
        Name = "${local.cluster_name}-public-subnet-${count.index + 1}"
        Environment = var.environment
        "kubernetes.io/cluster/${local.cluster_name}" = "owned"
        "kubernetes.io/role/elb" = "1"
    }
    depends_on = [ aws_vpc.eks_vpc ]
}


## Route Table Creation for Public Subnets
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.eks_vpc
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eks_igw.id
    }

    tags = {
        Name = "${local.cluster_name}-public-rt-table"
        Environment = var.environment
    }

    depends_on = [ aws_vpc.eks_vpc ]
  
}

## Public Subnet association
resource "aws_route_table_association" "public" {
  count = 3
  subnet_id      = aws_subnet.eks_public_subnet[count.index].id
  route_table_id = aws_route_table.public-rt.id

  depends_on = [ aws_vpc.eks_vpc, aws_subnet.eks_public_subnet ]
}

## Creating Elastic IP for Private Subnets

resource "aws_eip" "eks_nat_gateway_eip" {
  domain = "vpc"

  tags = {
    Name = "${local.cluster_name}-nat-gateway-eip"
    Environment = var.environment
  }

  depends_on = [ aws_vpc.eks_vpc ]
}

## Creating a NAT Gateway for Private Subnets

resource "aws_nat_gateway" "eks_nat_gateway" {
    allocation_id = aws_eip.eks_nat_gateway_eip.id
    subnet_id     = aws_subnet.eks_public_subnet[0].id
    
    tags = {
        Name = "${local.cluster_name}-nat-gateway"
        Environment = var.environment
    }
    
    depends_on = [ aws_vpc.eks_vpc, aws_eip.eks_nat_gateway_eip]
  
}


## ## Private Subnet Creation

resource "aws_subnet" "private-subnet" {
  count                   = var.eks_private_subnet_count
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = element(var.eks_private_subnet_cidr_blocks, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = false

    tags = {
        Name = "${local.cluster_name}-private-subnet-${count.index + 1}"
        Environment = var.environment
        "kubernetes.io/cluster/${local.cluster_name}" = "owned"
        "kubernetes.io/role/internal-elb" = "1"
    }
    depends_on = [ aws_vpc.eks_vpc ]
}

    
## ## private route table 
# resource "aws_route_table" "eks_private_route_table" {
#     vpc_id = aws_vpc.eks_vpc.id
#     route {
#         cidr_block = "0.0.0.0/0"
#         nat_gateway_id = aws_nat_gateway.eks_nat_gateway.id
#     }

#     tags = {
#         Name = "${local.cluster_name}-private-route-table"
#         Environment = var.environment
#     }
#     depends_on = [ aws_vpc.eks_vpc ]
# }

## ## Route Table Association for Private Subnets
resource "aws_route_table_association" "eks_private_subnet_route_table_association" {
  count = var.eks_private_subnet_count
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.eks_private_route_table.id
  
  depends_on = [ aws_vpc.eks_vpc, aws_subnet.private-subnet, aws_route_table.eks_private ]
}




## Route Table for Private Subnets to use NAT Gateway
resource "aws_route_table" "eks_private_route_table" {
    vpc_id = aws_vpc.eks_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.eks_nat_gateway.id
    }
  tags = {
        Name = "${local.cluster_name}-private-route-table"
        Environment = var.environment
    }
    depends_on = [ aws_vpc.eks_vpc, aws_nat_gateway.eks_nat_gateway ]
}

## SG For EKS-VPC
resource "aws_security_group" "eks_cluster_SG" {
    name = "${local.cluster_name}-SG"
    description = "Allow eks cluster access"
    vpc_id = aws_vpc.eks_vpc

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${local.cluster_name}-sg"
    }
}
