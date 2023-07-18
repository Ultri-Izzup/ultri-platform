"use strict";
import fp from "fastify-plugin";

function isUuid(testStr) {
  const regexExp = /^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$/gi;

  return(regexExp.test(testStr));
}

const funcs = {
  isUuid: isUuid
}

export default fp(function(server, opts, done) {
  server.decorate("funcs", funcs);
  done();
});