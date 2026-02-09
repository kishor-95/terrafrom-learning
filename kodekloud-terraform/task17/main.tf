resource "aws_dynamodb_table" "table" {
    name = "devops-user"
    hash_key = "devops_id"
    billing_mode = "PAY_PER_REQUEST"

 attribute {
    name = "UserId"
    type = "S"
  }
}
