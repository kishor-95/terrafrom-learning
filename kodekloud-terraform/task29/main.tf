# Add your code below
## This is for importing the bucket to run terraform import aws_s3_bucket.example <bucket_name>
resource "aws_s3_bucket" "example" {
  bucket = "datacenter-bck-12531"
  force_destroy = true
  depend_on = [null_resource.backup_to_local]
}

resource "null_resource" "backup_to_local" {
  provisioner "local-exec" {
    command = "aws s3 sync s3://${aws_s3_bucket.example.bucket}  /opt/s3-backup/"
  }

   triggers = {
    bucket = aws_s3_bucket.example.bucket_name
  }
}
