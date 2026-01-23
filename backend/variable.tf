variable "aws_bucket_name" {
  description = "The name of the AWS S3 bucket"
  type = string
  default = "test-terraform-state-backend-bucket-30-12-2025"

}

variable "env" {
  description = "This define the environment"
  type = string
  default = "dev"
}
variable "table_name" {
  description = "The name of the DynamoDB table"
  type = string
  default = "terraform-locks"
}