resource "aws_api_gateway_deployment" "process_car_parking_service_deployment" {
  depends_on = [
    aws_api_gateway_method.post_method,
    aws_api_gateway_method.get_method,
    aws_api_gateway_method.delete_method,
    aws_api_gateway_integration.post_integration,
    aws_api_gateway_integration.get_integration,
    aws_api_gateway_integration.delete_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.process_car_parking_service.id  # ID do API Gateway
  stage_name  = "prod"  # Nome do estágio para deployment

  variables = {
    "environment" = "production"
  }
}
