resource "aws_api_gateway_deployment" "vagasaservice_api" {
  depends_on = [
    aws_api_gateway_method.post_farmer_service,
    aws_api_gateway_method.get_farmer_service,
    aws_api_gateway_method.put_farmer_service,
    aws_api_gateway_method.delete_farmer_service,
    aws_api_gateway_integration.post_farmer_service,
    aws_api_gateway_integration.get_farmer_service,
    aws_api_gateway_integration.put_farmer_service,
    aws_api_gateway_integration.delete_farmer_service
  ]
  rest_api_id = aws_api_gateway_rest_api.vagasaservice_api.id
  stage_name  = "prod"
}