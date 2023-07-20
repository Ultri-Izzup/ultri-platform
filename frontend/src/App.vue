<template>
  <router-view />
</template>

<script setup>
import { defineComponent, watch } from "vue";
import { useQuasar } from "quasar";
import { storeToRefs } from "pinia";

import SuperTokens from "supertokens-web-js";
import Session from "supertokens-web-js/recipe/session";
import Passwordless from "supertokens-web-js/recipe/passwordless";

import { useAuthStore } from "./stores/auth";
import { useOrgStore } from "./stores/org";

const auth = useAuthStore();
const org = useOrgStore();

const { isSignedIn } = storeToRefs(auth);

watch(isSignedIn, () => {
  console.log('SIGNED IN', isSignedIn)
  if(!isSignedIn.value) {
    org.$reset();
  }
});

let apiHost;
if (process.env.DEV) {
  apiHost = "https://example.com";
}
if (process.env.PROD) {
  apiHost = "https://api.service.ultri.com";
}
console.log("APIHOST", apiHost);

SuperTokens.init({
  // enableDebugLogs: true,
  appInfo: {
    apiDomain: apiHost,
    apiBasePath: "/auth",
    appName: "Ultri",
  },
  recipeList: [
    Session.init({ getTokenTransferMethod: () => "cookie" }),
    Passwordless.init(),
  ],
});


const $q = useQuasar();

console.log($q.dark.isActive);
</script>
