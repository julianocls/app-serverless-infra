output "cognito_pool_id" {
  value = aws_cognito_user_pool.this.id
}

output "cognito_client_id" {
  value = aws_cognito_user_pool_client.this.id
}

output "cognito_url" {
  value = "https://${aws_cognito_user_pool_domain.this.domain}.auth.${var.aws_region}.amazoncognito.com"
}

output "lambda_s3_url" {
  value = aws_lambda_function.s3.invoke_arn
}

output "lambda_dynamo_url" {
  value = aws_lambda_function.dynamo.invoke_arn
}

output "api_url" {
  value = aws_api_gateway_deployment.this.invoke_url
}

output "bucket_name" {
  value = aws_s3_bucket.todo.bucket
}