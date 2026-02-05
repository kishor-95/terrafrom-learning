resource "aws_s3_bucket" "nautilus_s3_private" {
  bucket = "nautilus-s3-29871"
}


resource "aws_s3_bucket_public_access_block" "private_bucket" {
  bucket = aws_s3_bucket.nautilus_s3_private.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "bucket_address" {
  value = aws_s3_bucket.nautilus_s3_private.bucket_domain_name
}

