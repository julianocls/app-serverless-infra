data "archive_file" "s3" {
  type        = "zip"
  source_file = "${local.lambdas_path}/s3/index.js"
  output_path = "files/s3-artefact.zip"
}

resource "aws_lambda_function" "s3" {
  function_name = "s3"
  handler       = "index.handler"
  role          = aws_iam_role.s3.arn
  runtime       = "nodejs18.x"

  filename         = data.archive_file.s3.output_path
  source_code_hash = data.archive_file.s3.output_base64sha256

  environment {
    variables = {
      TOPIC_ARN = aws_sns_topic.this.arn
    }
  }

  tags = local.common_tags
}

resource "aws_lambda_permission" "s3" {
  statement_id  = "AllowExecutionFromS3Function"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.todo.arn
}

data "archive_file" "dynamo" {
  type        = "zip"
  source_file = "${local.lambdas_path}/dynamo/index.js"
  output_path = "files/dynamo-artefact.zip"
}

resource "aws_lambda_function" "dynamo" {
  function_name = "dynamo"
  handler       = "index.handler"
  role          = aws_iam_role.dynamo.arn
  runtime       = "nodejs18.x"

  filename         = data.archive_file.dynamo.output_path
  source_code_hash = data.archive_file.dynamo.output_base64sha256

  timeout     = 30
  memory_size = 128

  environment {
    variables = {
      TABLE = aws_dynamodb_table.this.name
    }
  }
}

resource "aws_lambda_permission" "dynamo" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dynamo.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:*/*"
}

resource "aws_lambda_permission" "sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dynamo.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.this.arn
}