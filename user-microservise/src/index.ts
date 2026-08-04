import type { APIGatewayProxyEvent, APIGatewayProxyResult, Context } from "aws-lambda";

export const handler = async (
  event: APIGatewayProxyEvent,
  context: Context
): Promise<APIGatewayProxyResult> => {
  console.log("Event:", JSON.stringify(event));

  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Hello from user-microservise test!" }),
  };
};