"use strict";
import fp from "fastify-plugin";


export default fp(function(fastify, opts, done) {
    fastify.register(require('@fastify/cookie'), {
        secret: "my-secret", // for cookies signature
        secure: true,
        // hook: 'onRequest', // set to false to disable cookie autoparsing or set autoparsing on any of the following hooks: 'onRequest', 'preParsing', 'preHandler', 'preValidation'. default: 'onRequest'
        // parseOptions: {}  // options for parsing cookies
      })
  done();
});
