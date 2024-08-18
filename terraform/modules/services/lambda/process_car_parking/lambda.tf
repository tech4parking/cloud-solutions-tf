resource "aws_lambda_function" "process_car_parking" {
  function_name = "process_car_parking-lambda-processing"
  role          = var.iam_role_lambda_exec_arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.process_car_parking_ecr.repository_url}:latest"
  timeout       = 300

  environment {
    variables = {
      TABLE_NAME = "process_car_parkingLambda"
    }
  }

  lifecycle {
    ignore_changes = [image_uri]  # Ignora mudanças no URI da imagem para evitar recriação
  }
}
