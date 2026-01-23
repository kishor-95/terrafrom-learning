resource "aws_s3_bucket" "bucket" {
    bucket = var.aws_bucket_name

    tags = {
        Name = "Terraform State Bucket"
        env  = var.env
    }
}