resource "aws_iot_topic_rule" "process_car_parking_iot_rule" {
  name        = "process_soil_car_parking"
  sql         = "SELECT * FROM 'soil_car_parking'"
  sql_version = "2016-03-23"
  enabled     = true  // Adicione esta linha

  lambda {
    function_arn = var.process_car_parking_lambda_arn
  }
}
