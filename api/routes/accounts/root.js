import fastifyPlugin from "fastify-plugin";
import { verifySession } from "supertokens-node/recipe/session/framework/fastify/index.js";

async function accountsRoutes(server, options) {
  server.get(
    "/accounts",
    {
      preHandler: verifySession(),
      schema: {
        description: "Get authenticated member accounts",
        tags: ["accounts"],
        summary: "Get all accounts for the authenticated member",
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              accounts: {
                type: "array",
                items: {
                  type: "object",
                  properties: {
                    accountUid: { type: "string" },
                    createdAt: { type: "string" },
                    name: { type: "string" },
                    roles: { type: "array", items: { type: "string" } },
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

      const accounts = await server.accountService.getMemberAccounts(memberUid);

      return {
        accounts: accounts,
      };
    }
  );

  server.post(
    "/accounts",
    {
      preHandler: verifySession(),
      schema: {
        description: "Create a new account",
        tags: ["accounts"],
        summary: "Add a new account to the databases",
        body: {
          type: "object",
          properties: {
            name: {
              type: "string",
              description: "The name for the account",
            },
          },
        },
        response: {
          200: {
            description: "Success Response",
            type: "object",
            properties: {
              accountUid: { type: "string" },
              name: { type: "string" },
              createdAt: { type: "string" },
              roles: { type: "array", items: { type: "string" } },
            },
          },
        },
      },
    },
    async (request, reply) => {
      let userId = request.session.getUserId();

      const result = await server.accountService.createAccount(
        request.body,
        userId
      );

      return result;
    }
  );
}

export default fastifyPlugin(accountsRoutes);
