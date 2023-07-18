import fastifyPlugin from "fastify-plugin";
import { verifySession } from "supertokens-node/recipe/session/framework/fastify/index.js";

async function entryEntryCreateRoutes(server, options) {
  server.get(
    "/comments/:commentUid",
    {
      preHandler: verifySession(),
      schema: {
        description: "Get a comment",
        tags: ["comments"],
        summary: "Get a single comment",
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              commentUid: { type: "string" },
              createdAt: { type: "string" },
              updatedAt: { type: "string" },
              note: { type: "string" },
              pubAt: { type: "string" },
              unPubAt: { type: "string" },
              publicTitle: { type: "string" },
              internalName: { type: "string" },
              blocks: {
                type: "array",
                items: {
                  type: "object",
                  properties: {
                    blockType: { type: "string" },
                    data: { type: "object" },
                  },
                },
              },
              nuggetType: { type: "string" },
            },
          },
        },
      },
    },
    async (request, reply) => {
      const memberUid = request.session.getUserId();

      const commentUid = request.params.commentUid;

      const result = await server.commentService.getComment(
        memberUid,
        commentUid
      );

      return result;
    }
  );
  server.patch(
    "/comments/:commentUid",
    {
      preHandler: verifySession(),
      schema: {
        description: "Update a comment",
        tags: ["comments"],
        summary: "Update a comment",
        body: {
          type: "object",
          properties: {
            note: { type: "string" },
            pubAt: { type: "string" },
            unPubAt: { type: "string" },
            internalName: { type: "string" },
            publicTitle: { type: "string" },
            blocks: {
              type: "array",
              items: {
                type: "object",
                properties: {
                  blockType: { type: "string" },
                  data: { type: "object" },
                },
              },
            },
          },
        },
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              commentUid: { type: "string" },
              updatedAt: { type: "string" },
            },
          },
        },
      },
    },
    async (request, reply) => {
      const memberUid = request.session.getUserId();

      const commentUid = request.params.commentUid;

      const result = await server.commentService.patchComment(
        memberUid,
        commentUid,
        request.body
      );

      console.log("MYREESULT", result);

      return result;
    }
  );
}

export default fastifyPlugin(entryEntryCreateRoutes);
