import fastifyPlugin from "fastify-plugin";
import { verifySession } from "supertokens-node/recipe/session/framework/fastify/index.js";

async function createRoutes(server, options) {
  server.put(
    "/orgs/:orgUid/mission",
    {
      preHandler: verifySession(),
      schema: {
        description: "Update an org mission statement",
        tags: ["orgs"],
        summary: "Update the mission statement for an org",
        body: {
          type: "object",
          properties: {
            mission: {
              type: "string",
              description: "The organizations mission statement",
            },
          },
        },
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              nuggetUid: { type: "string" },
              updatedAt: { type: "string" },
            },
          },
        },
      },
    },
    async (request, reply) => {
      const memberUid = request.session.getUserId();

      const orgUid = request.params.orgUid;

      const missionStatement = request.body.mission;

      const result = await server.orgService.updateMissionStatement(
        memberUid,
        orgUid, 
        missionStatement
      );

      return result;
    }
  );

}

export default fastifyPlugin(createRoutes);
