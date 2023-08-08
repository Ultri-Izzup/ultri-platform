<template>
  <q-layout view="lHh Lpr lFf">
    <q-header :class="colorStore.darkMode ? 'u-navbar-dark' : 'u-navbar-light'">
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="mdi-menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        />
        <u-toolbar-title />
        <q-space></q-space>
        <u-toolbar-controls />
      </q-toolbar>
    </q-header>

    <!-- LEFT DRAWER -->
    <q-drawer v-model="leftDrawerOpen" show-if-above bordered>
      <HomepageDrawer v-if="route.meta.drawer == 'Homepage'"></HomepageDrawer>
      <DefaultDrawer v-if="route.meta.drawer == 'Default'"></DefaultDrawer>
      <LogbookDrawer v-if="route.meta.drawer == 'Logbook'"></LogbookDrawer>
      <CanvasDrawer v-if="route.meta.drawer == 'Canvas'"></CanvasDrawer>
      <DashboardDrawer
        v-if="route.meta.drawer == 'Dashboard'"
      ></DashboardDrawer>
      <OrgDrawer v-if="route.meta.drawer == 'Org'"></OrgDrawer>
      <CirclesDrawer v-if="route.meta.drawer == 'Circle'"></CirclesDrawer>
    </q-drawer>

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
      <CirclesDialog
        v-model="circlesStore.showCirclesDialog"
      ></CirclesDialog>
      <NewCircleDialog
        v-model="circlesStore.showNewCircleDialog"
      ></NewCircleDialog>
      <!-- PAGE VIEW -->
      <router-view />
    </q-page-container>

    <u-dynamic-footer />
  </q-layout>
</template>

<script setup>
import { ref, watch } from "vue";
import { useRoute } from "vue-router";
import { useQuasar } from "quasar";
import { useAuthStore } from "../stores/auth";
import { useOrgStore } from "../stores/org";
import { useColorStore } from "../stores/color";
import { useCirclesStore } from "../stores/circles";

import LogbookDrawer from "./drawers/LogbookDrawer.vue";
import DefaultDrawer from "./drawers/DefaultDrawer.vue";
import HomepageDrawer from "./drawers/HomepageDrawer.vue";
import CanvasDrawer from "./drawers/CanvasDrawer.vue";
import DashboardDrawer from "./drawers/DashboardDrawer.vue";
import OrgDrawer from "./drawers/OrgDrawer.vue";
import CirclesDrawer from "./drawers/CirclesDrawer.vue";

import PasswordlessAuthDialog from "../components/auth/dialog/PasswordlessDialog.vue";
import WelcomeDialog from "../components/auth/dialog/WelcomeDialog.vue";

import OrgCreateDialog from "../components/org/dialog/OrgCreateDialog.vue";
import OrgCreateLogbookEntryDialog from "../components/org/dialog/OrgCreateLogbookEntryDialog.vue";
import OrgMissionDialog from "../components/org/dialog/OrgMissionDialog.vue";
import CirclesDialog from "../components/circles/dialog/CirclesDialog.vue";
import NewCircleDialog from "../components/circles/dialog/NewCircleDialog.vue";

import UDynamicFooter from "../components/footer/UDynamicFooter.vue";
import UToolbarTitle from "../components/ultri/UToolbarTitle.vue";
import UToolbarControls from "../components/ultri/UToolbarControls.vue";

const $q = useQuasar();

const route = useRoute();

// Stores
const authStore = useAuthStore();
const colorStore = useColorStore();
const orgStore = useOrgStore();
const circlesStore = useCirclesStore();

watch(
  () => colorStore.darkMode,
  () => {
    if (colorStore.darkMode) {
      $q.dark.set(true)
    } else {
      $q.dark.set(false)
    }
  },
  { immediate: true }
);

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
a.noLinkStyle {
  a:link {
    color: inherit;
    text-decoration: none;
  }
  a:visited {
    color: inherit;
    text-decoration: none;
  }
  a:hover {
    color: inherit;
    text-decoration: none;
  }
  a:active {
    color: inherit;
    text-decoration: none;
  }
}
.u-navbar-light {
  background-color: white;
  color: $navbar-txt-lt;
}
.u-navbar-dark {
  background-color: $dark-page;
  color: $navbar-txt-dk;
}
</style>
