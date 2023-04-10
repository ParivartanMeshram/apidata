data "aws_lambda_function" "example_lambda" {
  function_name = "example-lambda"
}

data "template_file" "swagger" {
  template = <<EOF
{
  "swagger": "2.0",
  "info": {
    "version": "1.0",
    "title": "Example API"
  },
  "paths": {
    "/example": {
      "get": {
        "produces": [
          "application/json"
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        },
        "x-amazon-apigateway-integration": {
          "uri": "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${data.aws_lambda_function.example_lambda.arn}/invocations",
          "passthroughBehavior": "when_no_templates",
          "httpMethod": "POST",
          "type": "aws_proxy"
        }
      }
    }
  }
}
EOF
  vars = {
    region = var.region
  }
}
