variable "eip_name" {
    default = "devops-eip"
    type = string
}

data "aws_vpc" "default" {}
resource "aws_eip" "devopseip" {
    domain = "vpc"
    
 tags = {
    Name = var.eip_name
  }
}


output "eip" {
    value = aws_eip.devopseip.public_ip
}



