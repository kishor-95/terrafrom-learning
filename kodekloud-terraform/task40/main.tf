resource "aws_iam_policy" "iam_policy" {
  name        = var.KKE_iampolicy
  description = "Custom IAM policy created using Terraform"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = "*"
      }
    ]
  })
}
