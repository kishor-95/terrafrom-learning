resource "aws_iam_user" "example" {
    name = var.KKE_user

    tags = {
        Name = var.KKE_user
    }
}

output "id_user" {
    value = aws_iam_user.example.id
}
