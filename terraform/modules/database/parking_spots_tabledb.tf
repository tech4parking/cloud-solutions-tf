# Tabela para armazenar vagas de estacionamento
resource "aws_dynamodb_table" "parking_spots" {
  name           = "ParkingSpots"
  billing_mode    = "PAY_PER_REQUEST"
  hash_key        = "SpotID"
  attribute {
    name = "SpotID"
    type = "S"
  }
  attribute {
    name = "OwnerID"
    type = "S"
  }
  # Adicione outras configurações conforme necessário
}