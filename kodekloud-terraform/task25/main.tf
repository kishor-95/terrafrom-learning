# Provision EC2 instance
## Old Code 
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  subnet_id     = ""
  vpc_security_group_ids = [
    "sg-03a4bfab694ca7260"
  ]

  tags = {
    Name = "devops-ec2"
  }
}

## New Code 

# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.nano"
  subnet_id     = ""
  vpc_security_group_ids = [
    "sg-03a4bfab694ca7260"
  ]

  tags = {
    Name = "devops-ec2"
  }
}
