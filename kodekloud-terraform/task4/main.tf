variable "cidr_block" {
  default = "192.168.0.0/24"
  type    = string

}

variable "name" {
  default = "nautilus-vpc"
  type    = string
}

resource "aws_vpc" "nautilus_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}
