"use strict";
import fp from "fastify-plugin";
import fastifyPostgres from "@fastify/postgres";

export default fp(function(server, opts, done) {
  server.register(fastifyPostgres, {
    connectionString: server.config.API_POSTGRES_URI /* other postgres options */,
  });

  done();
});
