variable "instance_name" {
    description = "This is demo instance created throug terraform"
    type = string
    default = "learn-terraform"
}
variable "instance_type" {
    type = string
    default = "t3.micro"
}
variable "public_key_path" {
    description = "This is default local key for login on ec2 instance"
    type = string
    default = "/home/kbhairat/terraform/test-terra.pub"
}

variable "security_group_name" {
    description = "This is security group for test through terraform"
    type = string
    default = "terraform_sg"
}

variable "volume_size" {
    description = "This is root volume size for ec2 instance"
    type = number
    default = 10 
  
}

variable "volume_type" {
    description = "This is root volume type for ec2 instance"
    type = string
    default = "gp3"
  
}