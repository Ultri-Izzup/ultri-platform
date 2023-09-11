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
import { useWebConsentStore } from "./stores/webConsent";

const authStore = useAuthStore();
const orgStore = useOrgStore();
const webConsentStore = useWebConsentStore();

const { isSignedIn, signOut } = storeToRefs(authStore);
watch(isSignedIn, () => {
  console.log('SIGNED IN', isSignedIn)
  if(!isSignedIn.value) {
    orgStore.$reset();
    webConsentStore.$reset();
  }
});

const { cookiePolicyAccepted, authCookiesAccepted, trackingCookiesAccepted } = storeToRefs(webConsentStore);
watch(cookiePolicyAccepted, async () => {

  if(!cookiePolicyAccepted.value) {
    trackingCookiesAccepted.value = false;
    authCookiesAccepted.value = false;
    await authStore.signOut();
  }
});

let apiHost;
if (process.env.DEV) {
  apiHost = "https://example.com";
}
if (process.env.PROD) {
  apiHost = "https://api.service.ultri.com";
}

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

</script>
