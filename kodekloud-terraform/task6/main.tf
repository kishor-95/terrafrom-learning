variable "eip_name" {
    default = "devops-eip"
    type = string
}

data "aws_vpc" "default" {}

resource "aws_eip" "devops_eip" {
  vpc = data.aws_vpc.default
  tags = {
    Name = var.eip_name
  }
}



