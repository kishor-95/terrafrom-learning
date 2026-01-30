resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0400"
}
## default vpc_id

data "aws_vpc" "default" {}


## security Group

data "aws_security_group" "default" {
    name = "default"
    vpc_id = data.aws_vpc.default.id
}


## ec2 instance
resource "aws_instance" "example" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.default.id]
  key_name               = aws_key_pair.my_key.key_name

  tags = {
    Name = var.instance_name
  }
}

