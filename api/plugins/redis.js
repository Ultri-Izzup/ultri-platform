"use strict";
import fp from "fastify-plugin";
import fastifyRedis from "@fastify/redis";

export default fp(function(server, opts, done) {
  server.register(fastifyRedis, {
    url: server.config.REDIS_URI /* other redis options */,
  });
  done();
});
