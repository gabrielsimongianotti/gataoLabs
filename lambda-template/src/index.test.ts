import { describe, expect, it } from "vitest";
import type { APIGatewayProxyEvent, Context } from "aws-lambda";
import { handler } from "./index";

function mockEvent(overrides: Partial<APIGatewayProxyEvent> = {}): APIGatewayProxyEvent {
  return {
    path: "/",
    httpMethod: "GET",
    requestContext: {} as APIGatewayProxyEvent["requestContext"],
    body: null,
    ...overrides,
  } as APIGatewayProxyEvent;
}

const mockContext: Context = {} as Context;

describe("handler", () => {
  it("returns a 200 response with a hello message", async () => {
    const result = await handler(mockEvent(), mockContext);

    expect(result.statusCode).toBe(200);
    expect(JSON.parse(result.body)).toEqual({ message: "Hello from Lambda!" });
  });
});