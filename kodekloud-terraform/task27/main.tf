# Create IAM user
resource "aws_iam_user" "user" {
  name = "iamuser_yousuf"

  tags = {
    Name = "iamuser_yousuf"
  }
}

# Create IAM Policy
resource "aws_iam_policy" "policy" {
  name        = "iampolicy_yousuf"
  description = "IAM policy allowing EC2 read actions for yousuf"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:Read*"]
        Resource = "*"
      }
    ]
  })
}


## Attaching the IAM Policy

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  users      = [aws_iam_user.user.name]
  policy_arn = aws_iam_policy.policy.arn
}
