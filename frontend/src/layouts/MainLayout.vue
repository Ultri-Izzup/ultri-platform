<template>
  <q-layout view="lHh Lpr lFf">
    <u-header @toggleDrawer="toggleLeftDrawer()"></u-header>
    <!-- LEFT DRAWER -->
    <div v-if="route.meta.drawer">
      <q-drawer v-model="leftDrawerOpen" show-if-above bordered>
        <HomepageDrawer v-if="route.meta.drawer == 'Homepage'" />
        <DefaultDrawer v-if="route.meta.drawer == 'Default'" />
        <LogbookDrawer v-if="route.meta.drawer == 'Logbook'" />
        <CanvasDrawer v-if="route.meta.drawer == 'Canvas'" />
        <OrgDrawer v-if="route.meta.drawer == 'Org'" />
        <OrgCirclesDrawer v-if="route.meta.drawer == 'OrgCircle'" />
        <CirclesDrawer v-if="route.meta.drawer == 'Circle'" />
      </q-drawer>
    </div>

    <!-- PAGE -->
    <q-page-container>
      <!-- DIALOGS -->
      <PasswordlessAuthDialog
        v-model="authStore.signInRequired"
      ></PasswordlessAuthDialog>
      <WelcomeDialog v-model="authStore.isNewMember"></WelcomeDialog>
      <OrgCreateLogbookEntryDialog
        v-model="orgStore.showOrgCreateLogbookEntryDialog"
      ></OrgCreateLogbookEntryDialog>
      <OrgCreateDialog v-model="orgStore.showOrgCreateDialog"></OrgCreateDialog>
      <OrgMissionDialog
        v-model="orgStore.showOrgMissionDialog"
      ></OrgMissionDialog>
      <!-- PAGE VIEW -->
      <router-view />
    </q-page-container>

    <u-dynamic-footer />
  </q-layout>
</template>

<script setup>
import { ref, watch } from "vue";
import { useRoute } from "vue-router";
import { useQuasar, setCssVar } from "quasar";
import { useAuthStore } from "../stores/auth";
import { useOrgStore } from "../stores/org";
import { useColorStore } from "../stores/color";

import LogbookDrawer from "./drawers/LogbookDrawer.vue";
import DefaultDrawer from "./drawers/DefaultDrawer.vue";
import HomepageDrawer from "./drawers/HomepageDrawer.vue";
import CanvasDrawer from "./drawers/CanvasDrawer.vue";
import OrgDrawer from "./drawers/OrgDrawer.vue";
import CirclesDrawer from "./drawers/CirclesDrawer.vue";
import OrgCirclesDrawer from "./drawers/OrgCirclesDrawer.vue";

import PasswordlessAuthDialog from "../components/auth/dialog/PasswordlessDialog.vue";
import WelcomeDialog from "../components/auth/dialog/WelcomeDialog.vue";

import OrgCreateDialog from "../components/org/dialog/OrgCreateDialog.vue";
import OrgCreateLogbookEntryDialog from "../components/org/dialog/OrgCreateLogbookEntryDialog.vue";
import OrgMissionDialog from "../components/org/dialog/OrgMissionDialog.vue";

import UHeader from "../components/ultri/UHeader.vue";
import UDynamicFooter from "../components/footer/UDynamicFooter.vue";

const $q = useQuasar();

const route = useRoute();

// Stores
const authStore = useAuthStore();
const colorStore = useColorStore();
const orgStore = useOrgStore();

// watch(
//   () => colorStore.darkMode,
//   () => {
//     if (colorStore.darkMode) {
//       $q.dark.set(true);
//       setCssVar("primary", "#424242");
//     } else {
//       $q.dark.set(false);
//       setCssVar("primary", "#747BFF");
//     }
//   },
//   { immediate: true }
// );

watch(
  () => route.params.orgUid,
  () => {
    if (route.params.orgUid) {
      orgStore.setCurrentOrg(route.params.orgUid);
    }
  },
  { immediate: true }
);

const leftDrawerOpen = ref(false);

const toggleLeftDrawer = () => {
  leftDrawerOpen.value = !leftDrawerOpen.value;
};
</script>

<style lang="scss">
.u-navbar-light {
  background-color: white;
  color: $navbar-txt-lt;
}
.u-navbar-dark {
  background-color: $dark-page;
  color: $navbar-txt-dk;
}
</style>
