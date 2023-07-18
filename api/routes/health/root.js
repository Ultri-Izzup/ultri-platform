import fastifyPlugin from "fastify-plugin";
import { verifySession } from "supertokens-node/recipe/session/framework/fastify/index.js";

async function healthRoutes(server, options) {
  server.get("/health",
  {
    schema: {
      description:
        "This is an endpoint for basic API health check",
      tags: ["health"],
      summary: "Verify the app server is up",
      response: {
        200: {
          description: "Success Response",
          type: "object",
          properties: {
            status: { type: "string" },
          },
        },
      },
    },
  },
  async (request, reply) => {
    return {
      status: "OK",
    };
  });
}

export default fastifyPlugin(healthRoutes);