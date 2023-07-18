import fastifyPlugin from "fastify-plugin";
import { verifySession } from "supertokens-node/recipe/session/framework/fastify/index.js";

async function entryEntryCreateRoutes(server, options) {
  server.get(
    "/entries/:logbookEntryUid/comments",
    {
      preHandler: verifySession(),
      schema: {
        description: "Get a logbook entry's comments",
        tags: ["entries","comments"],
        summary: "Get a logbook entry's top-level comments.",
        response: {
          200: {
            description: "Success Response",
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
        },
      },
    },
    async (request, reply) => {
      const memberUid = request.session.getUserId();

      const logbookEntryUid = request.params.logbookEntryUid;

      const result = await server.commentService.getLogbookEntryComments(memberUid, logbookEntryUid);

      return {comments: result };
    }
  );

  server.post(
    "/entries/:logbookEntryUid/comments",
    {
      preHandler: verifySession(),
      schema: {
        description: "Create a new logbook entry comment",
        tags: ["entries","comments"],
        summary: "Comment on a logbook entry",
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
              commentNuggetUid: { type: "string" },
              createdAt: { type: "string" }
            },
          },
        },
      },
    },
    async (req, reply) => {
      const memberUid = req.session.getUserId();

      const logbookEntryUid = req.params.logbookEntryUid;

      let result;

      let metaData = {};
      metaData.note = req.body.note ? req.body.note : null;

      // If there is nugget data, we need to create the nugget first.
      if(req.body.nugget)  {

        // console.log(memberUid, logbookEntryUid, metaData, req.body.nugget)

        // Use the logbookUid to get the proper org_id
        result = await server.nuggetService.createNuggetWithLogbookEntryComment(memberUid, logbookEntryUid, metaData, req.body.nugget);

      } else {
        result = await server.logbookEntryService.createLogbookEntryComment(memberUid, logbookEntryUid, metaData);
      }

      console.log('REEESULT', result)

      return result;
    }
  );
 
}

export default fastifyPlugin(entryEntryCreateRoutes);