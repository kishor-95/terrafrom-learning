resource "aws_iam_policy" "policy" {
  name        = "iampolicy_rose"
  path        = "/"
  description = "description = "Read-only access to EC2 console: instances, AMIs, and snapshots"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeSnapshots",
          "ec2:DescribeTags",  
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
