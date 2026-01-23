resource "aws_s3_bucket" "static_website" {
  bucket = var.bucket_name
}


## Blocking Public Access to the S3 Bucket
resource "aws_s3_bucket_public_access_block" "s3-block-public-access" {
  bucket     = aws_s3_bucket.static_website.id
  depends_on = [aws_s3_bucket.static_website]

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

## Origin Access Identity for CloudFront
resource "aws_cloudfront_origin_access_control" "oca" {
  name                              = "static-website-oca"
  description                       = "Origin Access Control for S3 static website"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


## S3 Bucket Policy to allow CloudFront access

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.static_website.id
  depends_on = [ aws_cloudfront_distribution.s3_distribution ]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontAccess"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.static_website.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.s3_distribution.arn
          }
        }
      }
    ]
  })
}



## Uploading Sample Index File to S3 Bucket

resource "aws_s3_object" "index_file" {
  for_each = fileset("${path.module}/app", "**.*")
  bucket   = aws_s3_bucket.static_website.id
  key      = each.value
  source   = "${path.module}/app/${each.value}"
  etag     = filemd5("${path.module}/app/${each.value}")
  content_type = lookup({
    "html" = "text/html"
    "css"  = "text/css"
    "js"   = "application/javascript"
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "gif"  = "image/gif"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream")
}


## cloudfront distribution and other resources would go here

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.static_website.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oca.id
    origin_id                = "S3-${aws_s3_bucket.static_website.id}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"


  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.static_website.id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
# data "aws_iam_policy_document" "allow_access_from_another_account" {
#   statement {
#     principals {
#       type        = "AWS"
#       identifiers = ["123456789012"]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:ListBucket",
#     ]

#     resources = [
#       aws_s3_bucket.example.arn,
#       "${aws_s3_bucket.example.arn}/*",
#     ]
#   }
# }