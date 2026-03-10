data "aws_vpc" "default" {}


resource "aws_security_group" "example" {
  name = var.KKE_sg
  description = "Created using terraform"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "${var.KKE_sg}"
  }
}
