resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.ssh_key.private_key_pem}' > $(PATH_MOUDLE)/my-key-pair.pem"
  }
}  


## security Group

data "aws_security_group" "default" {}

## ec2 instance

resource "aws_ec2_instance" "example" {
        ami = var.ami
        instance_type = var.instance_type
        vpc_security_group_ids = data.aws_security_group.default


    tags = {
        Name = var.instance_name
        }
}
