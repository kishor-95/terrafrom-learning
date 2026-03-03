terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28.0"
    }
  }
  required_version = ">= 1.5.0"
  backend "s3" {
  	bucket = "eks-cluster-tf-state-bucket-03-2026"
	region = "ap-south-1"
	use_lockfile = true
	key = "voting-app/terraform.tfstate"
  }
}

provider "aws" {
  region = "ap-south-1"
}
