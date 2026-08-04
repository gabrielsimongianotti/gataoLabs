resource "null_resource" "build_lambda" {
  triggers = {
    # rebuild whenever src files change
    src_hash = sha256(join("", [
      for f in fileset("${path.module}/../../../user-microservise/src", "**/*.ts") :
      filesha256("${path.module}/../../../user-microservise/src/${f}")
    ]))
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/../../../user-microservise"
    command     = "npm install && npm run build"
  }
}
resource "aws_lambda_function" "main" {
  function_name    = var.function_name
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  role    = aws_iam_role.lambda_exec.arn
  handler = "index.handler"
  runtime = "nodejs20.x"

  environment {
    variables = {
      ENV        = var.environment
      TABLE_NAME = aws_dynamodb_table.users.name
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic,
    aws_iam_role_policy_attachment.dynamodb,
    null_resource.build_lambda
  ]
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../../../user-microservise/dist"
  output_path = "${path.module}/lambda.zip"

  depends_on = [null_resource.build_lambda]
}
