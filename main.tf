
resource "aws_api_gateway_rest_api" "example_api" {
  name = "example-api"
}


resource "aws_api_gateway_deployment" "example_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.example_api.id
  stage_name  = "dev"
}

resource "aws_api_gateway_stage" "example_api_stage" {
  deployment_id = aws_api_gateway_deployment.example_api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.example_api.id
  stage_name    = "dev"
}

resource "aws_api_gateway_documentation_version" "example_api_docs" {
  rest_api_id     = aws_api_gateway_rest_api.example_api.id
  version         = "1.0"
  description     = "Example API"
  document_format = "swagger"
  body            = data.template_file.swagger.rendered
}
