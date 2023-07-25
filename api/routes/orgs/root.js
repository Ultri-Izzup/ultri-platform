import fastifyPlugin from "fastify-plugin";
import { verifySession } from "supertokens-node/recipe/session/framework/fastify/index.js";


async function createRoutes(server, options) {
  server.get(
    "/orgs",
    {
      preHandler: verifySession(),
      schema: {
        description: "Get a members Organizations",
        tags: ["entries"],
        summary: "Get orgs for a given member",
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              orgs: { type: "array" }
            },
          },
        },
      },
    },
    async (request, reply) => {
      const memberUid = request.session.getUserId();

      const result = await server.orgService.getMemberOrgs(memberUid);

      return { orgs: result };
    }
  );
  
  server.post(
    "/orgs",
    {
      preHandler: verifySession(),
      schema: {
        description:
          "Create a new organization, a logbook is automatically created.",
        tags: ["accounts", "orgs"],
        summary: "Add a new org to the database",
        body: {
          type: "object",
          properties: {
            name: {
              type: "string",
              description: "The name for the organization",
            },
          },
        },
        response: {
          200: {
            description: "Success Response",
            type: "object",
            
                  properties: {
                    uid: { type: "string" },
                    name: { type: "string" },
                    createdAt: { type: "string" },
                    logbookUid: { type: "string" },

            },
          },
        },
      },
    },
    async (request, reply) => {
      const memberUid = request.session.getUserId();

      const result = await server.orgService.createMemberOrg(
        memberUid,
        request.body
      );

      return result;
    }
  );

  server.delete(
    "/orgs/:orgUid",
    { preHandler: verifySession(),},
    
        async (request, reply) => {
      const memberUid = request.session.getUserId();

      const orgUid = request.params.orgUid;

      console.log('MADE IT', memberUid)

      const result = await server.orgService.deleteMemberOrg(
        memberUid, orgUid);

      return result;
    }
  );
  
}

export default fastifyPlugin(createRoutes);