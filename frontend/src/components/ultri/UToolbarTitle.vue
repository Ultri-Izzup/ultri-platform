<template>
  <div>
    <!-- LOGO
    <q-avatar>
      <img src="https://handbook.Ultri.org/logo_light.jpg" />
    </q-avatar>
    -->
    <q-toolbar-title>
      <span class="text-bold"
        ><router-link :to="{ name: 'home' }" class="navbar-brand-link">{{
          orgStore.currentOrgUid &&
          authStore.isSignedIn &&
          orgStore.orgs.get(orgStore.currentOrgUid) &&
          route.meta.app &&
          route.meta.app &&
          route.params.orgUid == "Logbook"
            ? orgStore.orgs.get(orgStore.currentOrgUid).name
            : "Ultri"
        }}</router-link></span
      >
    </q-toolbar-title>
  </div>
</template>

<script setup>
import { useRoute } from "vue-router";

import { useColorStore } from "../../stores/color";
import { useAuthStore } from "../../stores/auth";
import { useOrgStore } from "../../stores/org";

const route = useRoute();

const canvasName = route.params.canvasName;

// Stores
const colorStore = useColorStore();
const authStore = useAuthStore();
const orgStore = useOrgStore();
</script>

<style lang="scss">
</style>
