<template>
  <div>
    <!-- LOGO
    <q-avatar>
      <img src="https://handbook.Ultri.org/logo_light.jpg" />
    </q-avatar>
    -->
    <q-toolbar-title>
      <span class="text-bold"
        ><span v-if="route.name != 'canvasPage'"><router-link :to="{ name: 'home' }" class="navbar-brand-link">{{
          orgStore.currentOrgUid &&
          authStore.isSignedIn &&
          orgStore.orgs.get(orgStore.currentOrgUid) &&
          route.meta.app &&
          route.meta.app &&
          route.params.orgUid == "Logbook"
            ? orgStore.orgs.get(orgStore.currentOrgUid).name
            : "Ultri"
        }}</router-link></span>
        <span v-else>
          <router-link :to="{ name: 'home' }" class="navbar-brand-link">Ultri</router-link>
         {{ $t('canvas.' + canvasTitle + '.name') }}
        </span>
        </span
      >
    </q-toolbar-title>
  </div>
</template>

<script setup>
import { computed } from "vue";
import { useRoute } from "vue-router";

import { useColorStore } from "../../stores/color";
import { useAuthStore } from "../../stores/auth";
import { useOrgStore } from "../../stores/org";

const route = useRoute();

const canvasTitle = computed(() => {
  return route.params.canvasName;
})

// Stores
const colorStore = useColorStore();
const authStore = useAuthStore();
const orgStore = useOrgStore();
</script>

<style lang="scss">
</style>
