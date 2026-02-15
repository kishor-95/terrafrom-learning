resource "aws_cloudformation_stack" "devops_stack" {
  name = "devops-stack"

  template_body = jsonencode({
    AWSTemplateFormatVersion = "2010-09-09"
    Description              = "S3 bucket with versioning enabled"

    Resources = {
      DevopsBucket = {
        Type = "AWS::S3::Bucket"
        Properties = {
          BucketName = "devops-bucket-8757"

          VersioningConfiguration = {
            Status = "Enabled"
          }
        }
      }
    }
  })
}

