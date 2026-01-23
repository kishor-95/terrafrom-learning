terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27.0"
    }
  }

  required_version = ">= 1.2"
  backend "s3" {
    bucket = "Enter_your_bucket_name" # replace with your bucket name
    key    = "terraform.tfstate"
    region = "us-east-1"   # replace with your bucket region
    dynamodb_table = "Enter_your_dynamodb_table_name" # replace with your DynamoDB table name for state locking
    hash_key = "LockID"
    
    }
}



