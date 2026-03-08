resource "aws_s3_bucket" "my_bucket" {
  bucket = "devops-cp-23417"
  acl    = "private"

  tags = {
    Name        = "devops-cp-23417"
  }
}

resource "aws_s3_object" "file_upload" {
  bucket = "devops-cp-23417"
  key    = "devops.txt"
  source = "/tmp/devops.txt"
  etag   = filemd5("/tmp/devops.txt")
  content_type = "text/plain" # Adjust based on file type
}   
