import fastifyPlugin from "fastify-plugin";
import { verifySession } from "supertokens-node/recipe/session/framework/fastify/index.js";

async function logbookOrganizationsRoutes(server, options) {
  server.get(
    "/orgs/:orgUid/logbook/entries/:logbookEntryUid",
    {
      preHandler: verifySession(),
      schema: {
        description: "Get Logbook Entries for an Organization",
        tags: ["orgs", "logbooks"],
        summary: "Get logbook entries for a given org",
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              logbookEntryUid: { type: "string" },
              createdAt: { type: "string" },
              note: { type: "string" },
              nugget: {
                type: "object",
                properties: {
                  nuggetType: { type: "string" },
                  subtype: { type: "string" },
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
      },
    },
    async (request, reply) => {
      let memberUid = request.session.getUserId();

      const orgUid = request.params.orgUid;
      const logbookEntryUid = request.params.logbookEntryUid;

      const entry = await server.logbookService.getOrgLogbookEntry(
        memberUid,
        orgUid,
        logbookEntryUid
      );

      const entryData = entry[0];

      const entryWithNugget = {
        logbookEntryUid: entryData.logbookEntryUid,
        createdAt: entryData.createdAt,
        note: entryData.note,
        nugget: {
          nuggetType: entryData.nuggetType,
          subtype: entryData.subtype,
          pubAt: entryData.pubAt,
          unPubAt: entryData.unPubAt,
          internalName: entryData.internalName,
          publicTitle: entryData.publicTitle,
          blocks: entryData.blocks,
        },
      };

      return entryWithNugget;
    }
  );

  server.get(
    "/orgs/:orgUid/logbook/entries",
    {
      preHandler: verifySession(),
      schema: {
        description: "Get Logbook Entries for an Organization",
        tags: ["orgs", "logbooks"],
        summary: "Get logbook entries for a given org",
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              logbookEntries: {
                type: "array",
                items: {
                  type: "object",
                  properties: {
                    logbookEntryUid: { type: "string" },
                    createdAt: { type: "string" },
                    note: { type: "string" },
                    nuggetUid: { type: "string" },
                  },
                },
              },
            },
          },
        },
      },
    },
    async (request, reply) => {
      let memberUid = request.session.getUserId();

      const orgUid = request.params.orgUid;

      const entries = await server.logbookService.getOrgLogbookEntries(
        memberUid,
        orgUid
      );

      return {
        logbookEntries: entries,
      };
    }
  );

  server.post(
    "/orgs/:orgUid/logbook/entries",
    {
      preHandler: verifySession(),
      schema: {
        description: "Create a new logbook entry",
        tags: ["logbooks", "entries"],
        summary: "Add a new entry to the logbook",
        body: {
          type: "object",
          properties: {
            note: { type: "string" },
            nugget: {
              type: "object",
              properties: {
                nuggetType: { type: "string" },
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
        response: {
          200: {
            description: "Success Response",
            type: "object",

            properties: {
              logbookEntryUid: { type: "string" },
              createdAt: { type: "string" },
              nuggetUid: { type: "string" },
            },
          },
        },
      },
    },
    async (req, reply) => {
      const memberUid = req.session.getUserId();

      const orgUid = req.params.orgUid;

      let result;

      let metaData = {};
      metaData.note = req.body.note ? req.body.note : null;

      // If there is nugget data, we need to create the nugget first.
      if (req.body.nugget) {
        // Use the logbookUid to get the proper org_id
        result = await server.nuggetService.createMemberOrgLogbookNugget(
          memberUid,
          orgUid,
          metaData,
          req.body.nugget
        );
      } else {
        result = await server.logbookService.createOrgLogbookEntry(
          memberUid,
          orgUid,
          metaData
        );
      }

      console.log(result);
      result.note = metaData.note;

      return result;
    }
  );

  server.put(
    "/orgs/:orgUid/logbook/entries/:logbookEntryUid",
    {
      preHandler: verifySession(),
      schema: {
        description: "Update logbook entry",
        tags: ["logbooks", "entries"],
        summary: "Modify a logbook entry",
        body: {
          type: "object",
          properties: {
            note: { type: "string" },
            nugget: {
              type: "object",
              properties: {
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
        response: {
          200: {
            description: "Success Response",
            type: "object",

            properties: {
              updatedAt: { type: "string" }
            },
          },
        },
      },
    },
    async (req, reply) => {
      const memberUid = req.session.getUserId();

      const orgUid = req.params.orgUid;
      const logbookEntryUid = req.params.logbookEntryUid;

      let result;

      let metaData = {};
      metaData.note = req.body.note ? req.body.note : null;

      // If there is nugget data, we need to create the nugget first.
      if (req.body.nugget) {
        // Use the logbookUid to get the proper org_id
        result = await server.nuggetService.updateMemberOrgLogbookNugget(
          memberUid,
          orgUid,
          logbookEntryUid,
          metaData,
          req.body.nugget
        );
      } else {
        result = await server.logbookService.updateOrgLogbookEntry(
          memberUid,
          orgUid,
          logbookEntryUid,
          metaData
        );
      }

      console.log('RESULKSHHSHS', result);
      return result;
    }
  );
}

export default fastifyPlugin(logbookOrganizationsRoutes);
