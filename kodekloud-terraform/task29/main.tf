variable "bucket_name" {
  default = "datacenter-bck-12531"
}

resource "null_resource" "backup_and_delete" {

  provisioner "local-exec" {
    command = <<EOT
aws s3 sync s3://${var.bucket_name} /opt/s3-backup/ &&
aws s3 rb s3://${var.bucket_name} --force
EOT
  }

  triggers = {
    bucket = var.bucket_name
  }
}
