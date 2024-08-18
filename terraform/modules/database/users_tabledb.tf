# Tabela para armazenar usuários
resource "aws_dynamodb_table" "users" {
  name           = "Users"
  billing_mode    = "PAY_PER_REQUEST"
  hash_key        = "UserID"
  attribute {
    name = "UserID"
    type = "S"
  }
  attribute {
    name = "Email"
    type = "S"
  }
  # Adicione outras configurações conforme necessário
}