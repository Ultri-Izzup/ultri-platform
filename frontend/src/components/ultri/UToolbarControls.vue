<template>
  <div>
    <div>
      <span v-if="route.name != 'canvasPage'">
        <span class="q-pr-lg">
          <router-link to="/canava" class="navbar-text-link" color="primary">{{
            $t("nav.canava")
          }}</router-link>
        </span>
        <span class="q-pr-lg">
          <q-btn-dropdown flat color="primary" label="Editors" no-caps>
            <q-list>
              <q-item clickable v-close-popup href="/editors/markdown">
                <q-item-section>
                  <q-item-label>Markdown</q-item-label>
                </q-item-section>
              </q-item>

              <q-item clickable v-close-popup href="/editors/json">
                <q-item-section>
                  <q-item-label>JSON</q-item-label>
                </q-item-section>
              </q-item>

              <q-item clickable v-close-popup href="/editors/image">
                <q-item-section>
                  <q-item-label>Image</q-item-label>
                </q-item-section>
              </q-item>

              <q-item clickable v-close-popup href="/editors/audio">
                <q-item-section>
                  <q-item-label>Audio</q-item-label>
                </q-item-section>
              </q-item>

              <q-item clickable v-close-popup href="/editors/openapi">
                <q-item-section>
                  <q-item-label>OpenAPI</q-item-label>
                </q-item-section>
              </q-item>

            </q-list>
          </q-btn-dropdown>
        </span>
        <!-- <span class="gt-md q-pr-lg">
          <router-link to="/canvas" class="navbar-text-link" color="primary">{{
            $t("nav.canvas")
          }}</router-link>
        </span> -->
        <span class="gt-md q-pr-lg" v-if="featureStore.enabled('pricing')">
          <router-link to="/pricing" class="navbar-text-link" color="primary">{{
            $t("nav.pricing")
          }}</router-link>
        </span>
        <!-- <span class="gt-md q-pr-lg">
          <router-link
            to="/calendar"
            class="navbar-text-link"
            color="primary"
            >{{ $t("nav.calendar") }}</router-link
          >
        </span> -->
      </span>
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
  </div>
</template>

<script setup>
import { useRoute } from "vue-router";
import { useColorStore } from "../../stores/color";
import { useAuthStore } from "../../stores/auth";
import { useFeatureStore } from "../../stores/feature";

import MemberButton from "./button/MemberButton.vue";
import NotificationsButton from "./button/NotificationsButton.vue";

const route = useRoute();

// Stores
const colorStore = useColorStore();
const authStore = useAuthStore();
const featureStore = useFeatureStore();
</script>

<style lang="scss"></style>
