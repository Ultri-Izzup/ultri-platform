import fp from "fastify-plugin";

import swagger from "@fastify/swagger"
import swaggerUi from '@fastify/swagger-ui';

export default fp(async function(server, opts, done) {
  await server.register(swagger);

  await server.register(swaggerUi, {
    routePrefix: '/documentation',
    stripBasePath: false,
    swagger: {
        info: {
          title: 'OpenSociocracy API',
          description: 'OpenSociocracy Platform API',
          version: '0.1.0'
        },
        host: 'example.com',
        schemes: ['https','http'],
        consumes: ['application/json'],
        produces: ['application/json'],
        tags: [
          { name: 'accounts', description: 'Account related endpoints' },
          { name: 'orgs', description: 'Org related endpoints' }
        ],
        
      },

    uiConfig: {
      docExpansion: 'none',
      deepLinking: false 
    },
    uiHooks: {
      onRequest: function (request, reply, next) { next() },
      preHandler: function (request, reply, next) { next() }
    },
    staticCSP: true,
    transformStaticCSP: (header) => header,
    transformSpecification: (swaggerObject, request, reply) => { return swaggerObject },
    transformSpecificationClone: true
  })
})
