resource "aws_secretsmanager_secret" "aws_credentials" {
  name        = "aws-access-key"
  description = "AWS Access Key & Secret Key stored in Secrets Manager"
  recovery_window_in_days = 30
}


resource "aws_secretsmanager_secret_version" "aws_credentials_version" {
  secret_id     = aws_secretsmanager_secret.aws_credentials.id
  secret_string = jsonencode({
    access_key_id =  var.access_key.id
    secret_key_id =  var.secret_key.id
  })
}


data "aws_secretsmanager_secret_version" "aws_credentials" {
  secret_id = aws_secretsmanager_secret.aws_credentials.id
}


locals {
  aws_creds = jsondecode(data.aws_secretsmanager_secret_version.aws_credentials.secret_string)
}

