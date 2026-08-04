output "lambda_name" {
  value = aws_lambda_function.main.function_name
}

output "lambda_arn" {
  value = aws_lambda_function.main.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.users.name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.users.arn
}
