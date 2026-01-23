resource "aws_dynamodb_table" "state-lock" {
    name  = var.table_name
    hash_key = "LockID" 
    attribute {
        name = "LockID"
        type = "S"
    }
    billing_mode = "PAY_PER_REQUEST"    

    tags = {
        Name = "Terraform State Lock Table"
        env  = var.env
    }
  
}