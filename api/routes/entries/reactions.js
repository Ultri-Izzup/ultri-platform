import fastifyPlugin from "fastify-plugin";
import { verifySession } from "supertokens-node/recipe/session/framework/fastify/index.js";

async function entryEntryCreateRoutes(server, options) {
  server.get(
    "/entries/:logbookEntryUid/reactions",
    {
      preHandler: verifySession(),
      schema: {
        description: "Get a logbook entry's reactions",
        tags: ["entries","reactions"],
        summary: "Get a logbook entry's top-level reactions.",
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              reactions: { type: "array" },
            },
          },
        },
      },
    },
    async (request, reply) => {
      const memberUid = request.session.getUserId();

      const logbookEntryUid = request.params.logbookEntryUid;

      const result = await server.reactionService.getLogbookEntryReactions(memberUid, logbookEntryUid);

      return {reactions: result };
    }
  );

  server.put(
    "/entries/:logbookEntryUid/reactions",
    {
      preHandler: verifySession(),
      schema: {
        description: "Create a new logbook entry reaction",
        tags: ["entries","reactions"],
        summary: "Reaction on a logbook entry",
        body: {
          type: "object",
          properties: {
            name: {
              type: "string",
              description: "The name for the logbook",
              },
          },
        },
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              reactedAt: { type: "string" }
            },
          },
        },
      },
    },
    async (req, reply) => {
      const memberUid = req.session.getUserId();

      const logbookEntryUid = req.params.logbookEntryUid;

      let result;

      result = await server.logbookEntryService.setLogbookEntryReaction(memberUid, logbookEntryUid, req.body.reactions);

      return result;
    }
  );
 
}

export default fastifyPlugin(entryEntryCreateRoutes);