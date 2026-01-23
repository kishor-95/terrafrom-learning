# provider "aws" {
#   region = "us-east-1"
# }
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}
# Create a key pair
resource "aws_key_pair" "terraform_key" {
  key_name   = "test-terra"
  public_key = file(var.public_key_path)
  
}

# creating the vpc and security group


resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "test_terraform_sg" {
  name = var.security_group_name
  vpc_id= aws_default_vpc.default.id

  ingress  {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
   tags = {
    name = var.security_group_name
  }
 }


resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.terraform_key.key_name
  vpc_security_group_ids = [aws_security_group.test_terraform_sg.name]
  
  root_block_device {

    volume_size = var.volume_size
    volume_type = var.volume_type
  }
 
 
 tags = {
    Name = var.instance_name
  }
}