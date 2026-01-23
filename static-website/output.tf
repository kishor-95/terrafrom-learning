output "bucket_name" {
  value = aws_s3_bucket.static_website.id

}

output "cloudfront" {
  value = aws_cloudfront_distribution.s3_distribution
}