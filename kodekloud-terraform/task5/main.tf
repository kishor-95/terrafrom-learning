variable "cidr_block" {
  default = "10.1.0.0/24"
  type    = string

}

variable "name" {
  default = "devops-vpc"
  type    = string
}

resource "aws_vpc" "devops_vpc" {
  cidr_block = var.cidr_block
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = var.name
  }
}
