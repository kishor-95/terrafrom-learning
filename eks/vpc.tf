data "aws_availability_zones" "available" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name                 = "my-vpc-for-eks"
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = var.public_subnet
  private_subnets      = var.private_subnet
  enable_dns_hostnames = true
  enable_dns_support   = true
  single_nat_gateway   = true
  enable_nat_gateway   = true
  tags = {
    Terraform   = "true"
    Environment = var.env
  }

}