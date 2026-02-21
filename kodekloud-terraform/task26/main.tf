# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  subnet_id     = "subnet-add94649cfa6c07a3"
  vpc_security_group_ids = [
    "sg-a0d8edba9aedee65e"
  ]

  tags = {
    Name = "datacenter-ec2"
  }
}

# Provision Elastic IP
resource "aws_eip" "ec2_eip" {
  tags = {
    Name = "datacenter-ec2-eip"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2.id
  allocation_id = aws_eip.ec2_eip.id
}
