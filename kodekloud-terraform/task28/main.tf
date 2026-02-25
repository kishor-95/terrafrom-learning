resource "aws_s3_bucket" "s3_ran_bucket" {
  bucket = "devops-s3-13733"
  acl    = "private"


  tags = {
    Name        = "devops-s3-13733"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3_ran_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
