<template>
  <q-btn-dropdown flat dense no-caps dropdown-icon="mdi-account">
    <q-list>
      <!--
      <q-expansion-item
        expand-separator
        icon="mdi-account-switch"
        :label="account.currentAccountName"
        :caption="$t('account.caption')"
        expand-icon="mdi-menu-down"
        v-if="auth.isSignedIn"
      >
        <q-card>
          <q-card-section>

          </q-card-section>
        </q-card>
      </q-expansion-item>
      -->
      <!--
      <q-item clickable>
        <q-item-section avatar>
          <q-icon name="mdi-web" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-select
            v-model="locale"
            :options="locales"
            :label="$t('nav.language')"
            dense
            borderless
            emit-value
            map-options
            options-dense
            style="min-width: 150px"
          />
        </q-item-section>
      </q-item>
      -->
      <!--
      <q-item clickable v-close-popup @click="color.toggleDarkMode()">
        <q-item-section avatar>
          <q-icon name="mdi-theme-light-dark" color="primary"/>
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t('nav.darkMode') }}</q-item-label>
        </q-item-section>
      </q-item>
      -->
      <q-item clickable v-close-popup v-if="auth.isSignedIn" to="/dashboard">
        <q-item-section avatar>
          <q-icon name="mdi-view-dashboard" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t("nav.dashboard") }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-item clickable v-close-popup v-if="auth.isSignedIn" to="/orgs">
        <q-item-section avatar>
          <q-icon name="mdi-office-building" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t("nav.organizations") }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-item
        clickable
        v-close-popup
        v-if="!auth.isSignedIn"
        @click="triggerSignInDialog()"
      >
        <q-item-section avatar>
          <q-icon name="mdi-login" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t("nav.signIn") }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-item
        clickable
        v-close-popup
        v-if="auth.isSignedIn"
        @click="auth.signOut('/')"
      >
        <q-item-section avatar>
          <q-icon name="mdi-logout" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t("nav.signOut") }}</q-item-label>
        </q-item-section>
      </q-item>
    </q-list>
  </q-btn-dropdown>
</template>

<script setup language="ts">
import { useAuthStore } from "../../../stores/auth";
import { useColorStore } from "../../../stores/color";

import { useQuasar } from "quasar";
import { useI18n } from "vue-i18n";

import { useRouter } from "vue-router";

import { ref } from "vue";

const router = useRouter();

const $q = useQuasar();

const auth = useAuthStore();

const color = useColorStore();
$q.dark.set(color.darkMode);
color.$subscribe((mutation, state) => {
  $q.dark.set(state.darkMode);
});

const { locale } = useI18n({ useScope: "global" });

const locales = [
  { value: "en-US", label: "English" },
  { value: "es", label: "Español" },
];

const triggerSignInDialog = async () => {
  auth.setTargetUrl("/");
  auth.setSignInRequired(true);
};
</script>