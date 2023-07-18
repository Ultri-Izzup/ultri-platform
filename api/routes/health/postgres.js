import fastifyPlugin from "fastify-plugin";
import { verifySession } from "supertokens-node/recipe/session/framework/fastify/index.js";

// import postgresHealthServicePlugin from "../../services/postgresHealthService.js";

async function healthRoutes(server, options) {

  server.get(
    "/health/postgres",
    {
      schema: {
        description:
          "This is an endpoint for application Postgres database health check",
        tags: ["health"],
        summary: "Verify the database is accessible",
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
      let status = "FAIL";

      const dbCheck = await server.postgresHealthService.getNow();
      console.log('DBCHECK', dbCheck)

      const currentTime = new Date().getTime();
      const dbCurrentTime = new Date(dbCheck.current_timestamp).getTime();

      const drift = Math.abs(currentTime - dbCurrentTime);

      if (drift < 1000) {
        status = "OK";
      } else {
        status = "DRIFT-DETECTED";
      }

      return { status };
    }
  );
}

export default fastifyPlugin(healthRoutes);