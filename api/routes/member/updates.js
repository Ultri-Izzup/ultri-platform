import fastifyPlugin from "fastify-plugin";
import { verifySession } from "supertokens-node/recipe/session/framework/fastify/index.js";

async function createRoutes(server, options) {

  //server.addHook('preHandler', (request, reply, done) => {
  //  // some code
  //  verifySession()
  //  done()
  //})

    server.get(
      "/member/:memberUid/updates",
      {  websocket: true },
      async (connection, request) => {

        // Get the token from the querystring
        const token = request.params.token;

        // Client message
        connection.socket.on('message', message => {
            console.log(`Client message: ${message}`);
        });

        // Client disconnect
        connection.socket.on('close', () => {
            console.log('Client disconnected');
        });
      }
    );
}

export default fastifyPlugin(createRoutes);
