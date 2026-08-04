# user-microservise

A minimal TypeScript AWS Lambda used as the function source for the `lambda` Terraform module in this repo.

## What it is

A Node.js 20 (CommonJS) Lambda handler written in TypeScript. It receives an event, logs it, and returns a fixed `200` response with `{ "message": "Hello from Lambda!" }`.

Structure:

```
user-microservise/
├── src/index.ts       # handler source
├── package.json       # build scripts & deps
├── tsconfig.json
└── dist/              # compiled output (created by `npm run build`, gitignored)
```

The `dist/` folder is generated during the CI pipeline (`npm ci && npm run build`) and zipped by the Terraform `archive_file` data source into the deployed function.

## Invoking the deployed function

Run from anywhere with AWS credentials configured (`aws configure` or env vars), pointing at the deployed function:

```bash
aws lambda invoke \
  --function-name staging-user-microservise \
  --cli-binary-format raw-in-base64-out \
  --payload '{}' \
  cat_me.json && cat cat_me.json
```

`--cli-binary-format raw-in-base64-out` is required so the CLI passes the payload as-is (not base64). The response is written to `cat.json` and then printed. The output is the handler's full `APIGatewayProxyResult`, e.g.:

```json
{"statusCode":200,"body":"{\"message\":\"Hello from Lambda!\"}"}
```

To see the raw event the function received, check the Lambda logs in CloudWatch (`/aws/lambda/prod-function-gatao-labs`).
