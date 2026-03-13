resource "aws_iam_user" "example" {
    name = var.KKE_user

    tags = {
        Name = var.KKE_user
    }
}
