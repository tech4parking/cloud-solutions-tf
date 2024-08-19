# Certificado SSL
resource "aws_acm_certificate" "cert" {
  domain_name               = "vagasasaservice.com.br"
  validation_method         = "DNS"

  subject_alternative_names = [
    "www.vagasasaservice.com.br",
  ]

  tags = {
    Name = "vagasasaservice-certificate"
  }
}
