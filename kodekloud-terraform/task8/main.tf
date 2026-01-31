# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-e8f98d4e61fb24a62"
  ]

  tags = {
    Name = "nautilus-ec2"
  }
}


resource "aws_ami_from_instance" "custom_ami" {
  name               = "nautilus-ec2-ami"
  source_instance_id = aws_instance.ec2.id
}
