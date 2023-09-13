import cors from "@fastify/cors";
import formDataPlugin from "@fastify/formbody";
import fastifyPlugin from "fastify-plugin";

import supertokens from "supertokens-node";
import Session from "supertokens-node/recipe/session/index.js";
import EmailPassword from "supertokens-node/recipe/emailpassword/index.js";
import Passwordless from "supertokens-node/recipe/passwordless/index.js";
import { SMTPService } from "supertokens-node/recipe/passwordless/emaildelivery/index.js";
import ThirdPartyEmailPassword from "supertokens-node/recipe/thirdpartyemailpassword/index.js";
import {
  plugin,
  errorHandler,
} from "supertokens-node/framework/fastify/index.js";

async function auth(server, options) {
  supertokens.init({
    framework: "fastify",
    supertokens: {
      // These are the connection details of the app you created on supertokens.com
      connectionURI: server.config.SUPERTOKENS_CONNECTION_URI,
      apiKey: server.config.SUPERTOKENS_API_KEY,
    },
    appInfo: {
      // learn more about this on https://supertokens.com/docs/session/appinfo
      appName: server.config.SUPERTOKENS_APPNAME,
      apiDomain: server.config.SUPERTOKENS_API_DOMAIN,
      websiteDomain: server.config.SUPERTOKENS_WEBSITE_DOMAIN,
      apiBasePath: server.config.SUPERTOKENS_API_BASE_PATH,
      websiteBasePath: server.config.SUPERTOKENS_WEBSITE_BASE_PATH,
    },
    recipeList: [
      Passwordless.init({
        // flowType: "USER_INPUT_CODE_AND_MAGIC_LINK",
        flowType: "USER_INPUT_CODE",
        contactMethod: "EMAIL_OR_PHONE",
        emailDelivery: {
          service: new SMTPService({
            smtpSettings: {
              host: server.config.SMTP_HOST,
              authUsername: server.config.SMTP_USER, // this is optional. In case not given, from.email will be used
              password: server.config.SMTP_PASSWORD,
              port: server.config.SMTP_PORT,
              from: {
                name: server.config.SMTP_FROM,
                email: server.config.SMTP_EMAIL,
              },
              secure: server.config.SMTP_SECURE,
            },
          }),
        },
      }),
      EmailPassword.init(), // initializes signin / sign up features
      Session.init(
        {
            getTokenTransferMethod: () => "cookie", // "header",
            exposeAccessTokenToFrontendInCookieBasedAuth: true,
            override: {
              functions: (originalImplementation) => {
                  return {
                      ...originalImplementation,

                      // here we are only overriding the function that's responsible
                      // for creating a new session
                      consumeCode: async function (input) {
                          // TODO: some custom logic

                          // or call the default behaviour as show below
                          const originalResult = await originalImplementation.consumeCode(input);

                          console.log('ORIGINAL', originalResult);
                      },
                      // ...
                      // TODO: override more functions
                  }
              }
          }
          }), // initializes session features
    ],
  });

  // we register a CORS route to allow requests from the frontend
  server.register(cors, {
    origin: server.config.CORS_ORIGIN_URL,
    allowedHeaders: [
      "Content-Type",
      "anti-csrf",
      "rid",
      "fdi-version",
      "authorization",
      "st-auth-mode",
    ],
    methods: ["GET", "PUT", "POST", "DELETE", "PATCH"],
    credentials: true,
  });

  server.register(formDataPlugin);
  server.register(plugin);

  server.setErrorHandler(errorHandler());
}

export default fastifyPlugin(auth);


