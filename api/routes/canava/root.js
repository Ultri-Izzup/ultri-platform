import fastifyPlugin from "fastify-plugin";
import { verifySession } from "supertokens-node/recipe/session/framework/fastify/index.js";


async function createRoutes(server, options) {
  server.get(
    "/canava/canvases",
    {
      preHandler: verifySession(),
      schema: {
        description: "Get a members Canvases",
        tags: ["entries"],
        summary: "Get canvases for a given member",
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              canvases: { type: "array" }
            },
          },
        },
      },
    },
    async (request, reply) => {
      const memberUid = request.session.getUserId();

      const result = await server.canavaService.getMemberCanvases(memberUid);

      return { canvases: result };
    }
  );

  server.get(
    "/canava/canvases/:canvasUid",
    {
      preHandler: verifySession(),
      schema: {
        description: "Get a single Canvas",
        tags: ["entries"],
        summary: "Get a canvas by Uid",
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              canvases: { type: "array" }
            },
          },
        },
      },
    },
    async (request, reply) => {
      const memberUid = request.session.getUserId();

      const result = await server.canavaService.getMemberCanvas(memberUid, canvasUid);

      return { canvases: result };
    }
  );
  
  server.put(
    "/canava/canvases",
    {
      preHandler: verifySession(),
      schema: {
        description:
          "Insert or Update data for a given canvasUid",
        tags: ["canava"],
        summary: "Add/modify a given canvas",
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

      const result = await server.canavaService.setMemberCanvas(
        memberUid,
        request.body
      );

      return result;
    }
  );

  server.delete(
    "/canava/canvases/:canvasUid",
    { preHandler: verifySession(),},
    
        async (request, reply) => {
      const memberUid = request.session.getUserId();

      const canvasUid = request.params.canvasUid;

      console.log('MADE IT', memberUid)

      const result = await server.canavaService.deleteMemberCanvas(
        memberUid, canvasUid);

      return result;
    }
  );
  
}

export default fastifyPlugin(createRoutes);