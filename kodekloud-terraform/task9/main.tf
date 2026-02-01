data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_ebs_volume" "datacenter" {
  availability_zone = data.aws_availability_zones.available.names[0]
  size              = 2
  type              = "gp3"

  tags = {
    Name = "datacenter-volume"
  }
}
