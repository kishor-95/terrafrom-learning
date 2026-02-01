resource "aws_ebs_volume" "datacenter_volume" {
  size      = 2
  type      = "gp3"
  availability_zone = "us-east-1a"
  

  tags = {
    Name = "datacenter-volume"
  }
}
