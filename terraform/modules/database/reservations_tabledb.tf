# Tabela para armazenar reservas
resource "aws_dynamodb_table" "reservations" {
  name           = "Reservations"
  billing_mode    = "PAY_PER_REQUEST"
  hash_key        = "ReservationID"
  range_key       = "SpotID"
  attribute {
    name = "ReservationID"
    type = "S"
  }
  attribute {
    name = "SpotID"
    type = "S"
  }
  attribute {
    name = "UserID"
    type = "S"
  }
  # Adicione outras configurações conforme necessário
}