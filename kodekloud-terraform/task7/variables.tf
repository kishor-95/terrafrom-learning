variable "instance_name" {
    default = "nautilus-ec2"
    type    = string
}

variable "instance_type" {
    default = "t2.micro"
    type    = string
}

variable "key_name" {
    default = "nautilus-kp"
    type    = string
}

variable "ami" {
    default = "ami-0c101f26f147fa7fd"
    type    = string
}
