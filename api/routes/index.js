'use strict'
import fastifyPlugin from "fastify-plugin";

async function indexRoutes(server, options) {
  server.get("/",
  async (request, reply) => {
    return {
      status: "UNAUTHORIZED ACCESS PROHIBITED",
    };
  });
}

export default fastifyPlugin(indexRoutes);