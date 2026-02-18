resource "aws_secretsmanager_secret" "app_secret" {
  name = "devops-secret"
}

resource "aws_secretsmanager_secret_version" "app_secret_value" {
  secret_id = aws_secretsmanager_secret.app_secret.id

  secret_string = jsonencode({
    username = "admin"
    password = "Namin123"
  })
}

