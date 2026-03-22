resource "aws_apigatewayv2_api" "this" {
  name          = var.name
  protocol_type = "HTTP"
}
