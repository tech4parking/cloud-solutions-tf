# Configuração da Zona DNS
resource "aws_route53_zone" "vagasasaservice_zone" {
  name = "vagasasaservice.com.br"
}