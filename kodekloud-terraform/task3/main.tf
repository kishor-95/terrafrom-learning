variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "devops_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "xfusion_vpc"
  }
}

