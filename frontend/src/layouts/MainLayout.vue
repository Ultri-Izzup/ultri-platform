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
        <!-- TOOLBAR - RIGHT SIDE BUTTONS -->
        <div>
          <!--
          <span class="q-pr-lg">
          <router-link to="/benefits" class="navbar-text-link" color="primary">{{ $t("nav.benefits") }}</router-link>
          </span> -->
          <span class="q-pr-lg">
            <router-link
              to="/canvas"
              class="navbar-text-link"
              color="primary"
              >{{ $t("nav.canvas") }}</router-link
            >
          </span>
          <span class="q-pr-lg" v-if="featureStore.enabled('auth')">
            <router-link
              to="/pricing"
              class="navbar-text-link"
              color="primary"
              >{{ $t("nav.pricing") }}</router-link
            >
          </span>
          <span class="q-pr-lg">
            <router-link
              to="/calendar"
              class="navbar-text-link"
              color="primary"
              >{{ $t("nav.calendar") }}</router-link
            >
          </span>

          <!-- DISPLAY SIGN BUTTON
          <span>
            <sign-in-button v-if="!authStore.isSignedIn"></sign-in-button>
            <q-tooltip>{{ $t("nav.signIn") }}</q-tooltip></span
          >
          -->

          <q-toggle
            v-model="colorStore.darkMode"
            icon="mdi-theme-light-dark"
            dense
            color="blue-grey-9"
            size="sm"
          ></q-toggle>
          <!-- NOTIFICATIONS BUTTON -->

          <span v-if="featureStore.enabled('auth') && authStore.isSignedIn">
            <NotificationsButton></NotificationsButton>
            <q-tooltip>{{ $t("notifications.hint") }}</q-tooltip>
          </span>

          <!-- MEMBER BUTTON -->
          <span v-if="featureStore.enabled('auth')">
            <MemberButton></MemberButton>
            <q-tooltip>{{ $t("member.hint") }}</q-tooltip>
          </span>
        </div>
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
      <CircleDrawer v-if="route.meta.drawer == 'Circle'"></CircleDrawer>
    </q-drawer>

    <q-footer>
      <q-toolbar
        :class="colorStore.darkMode ? 'u-navbar-dark xs' : 'u-navbar-light xs'"
      >
        <div class="col">
          <q-space /><a href="https://coop.ultri.com" class="navbar-text-link"
            >Co-op Info</a
          >
          <q-space /><a
            href="https://www.opensociocracy.org"
            class="navbar-text-link"
            >OpenSociocracy</a
          >
        </div>
        <div class="col text-right justify-right">
          <q-space /><a
            href="https://www.linkedin.com/company/ultri/"
            class="navbar-text-link"
            >LinkedIn</a
          >
          <q-space />
          <div class="text-body2">Copyright &copy; 2023 Ultri</div>
        </div>
      </q-toolbar>
      <q-toolbar
        :class="
          colorStore.darkMode ? 'u-navbar-dark gt-xs' : 'u-navbar-light gt-xs'
        "
      >
        <q-space /><a href="https://coop.ultri.com" class="navbar-text-link"
          >Co-op Info</a
        >
        <q-space /><a
          href="https://www.opensociocracy.org"
          class="navbar-text-link"
          >OpenSociocracy</a
        >
        <q-space /><a
          href="https://www.linkedin.com/company/ultri/"
          class="navbar-text-link"
          >LinkedIn</a
        >
        <q-space />
        <div class="text-body2 q-pr-md">Copyright &copy; 2023 Ultri</div>
      </q-toolbar>
    </q-footer>

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
  </q-layout>
</template>

<script setup>
import { ref, watch, computed } from "vue";
import { useRoute } from "vue-router";
import { useQuasar } from "quasar";
import { useAuthStore } from "../stores/auth";
import { useOrgStore } from "../stores/org";
import { useColorStore } from "../stores/color";
import { useFeatureStore } from "../stores/feature";

import NotificationsButton from "../components/ultri/button/NotificationsButton.vue";
import MemberButton from "../components/ultri/button/MemberButton.vue";

import LogbookDrawer from "./drawers/LogbookDrawer.vue";
import DefaultDrawer from "./drawers/DefaultDrawer.vue";
import HomepageDrawer from "./drawers/HomepageDrawer.vue";
import CanvasDrawer from "./drawers/CanvasDrawer.vue";
import DashboardDrawer from "./drawers/DashboardDrawer.vue";
import OrgDrawer from "./drawers/OrgDrawer.vue";
import CircleDrawer from "./drawers/CircleDrawer.vue";

import PasswordlessAuthDialog from "../components/auth/dialog/PasswordlessDialog.vue";
import WelcomeDialog from "../components/auth/dialog/WelcomeDialog.vue";

import OrgCreateDialog from "../components/org/dialog/OrgCreateDialog.vue";
import OrgCreateLogbookEntryDialog from "../components/org/dialog/OrgCreateLogbookEntryDialog.vue";
import OrgMissionDialog from "../components/org/dialog/OrgMissionDialog.vue";

const $q = useQuasar();

const route = useRoute();

// Stores
const authStore = useAuthStore();
const colorStore = useColorStore();
const orgStore = useOrgStore();
const featureStore = useFeatureStore();

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
