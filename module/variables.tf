variable "vpc-name" {
    description = "This is name for vpc module"
    type = string
}

variable "environment" {
    description = "This define the environment"
    type = string
}

variable "cidr-range" {
    description = "The CIDR range for the VPC"
    type = string
  
}

variable "azs" {
    description = "A list of availability zones"
    type = list(string)
}