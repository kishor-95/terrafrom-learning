resource "aws_s3_bucket" "devops_s3_public" {
    bucket = "devops-s3-11613"
}


resource "aws_s3_bucket_public_access_block" "Pulic_bucket" {
  bucket = aws_s3_bucket.devops_s3_public.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
