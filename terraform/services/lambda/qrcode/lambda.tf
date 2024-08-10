resource "aws_lambda_function" "qrcode" {
  function_name = "qrcode-lambda-processing"
  role          = var.iam_role_lambda_exec_arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.qrcode.repository_url}:latest"
  timeout       = 300

  environment {
    variables = {
      TABLE_NAME = "QRCodeLambda"
    }
  }

  lifecycle {
    ignore_changes = [image_uri]  # Ignora mudanças no URI da imagem para evitar recriação
  }
}
