<template>
  <q-footer>
    <q-toolbar
      :class="colorStore.darkMode ? 'u-navbar-dark' : 'u-navbar-light'"
    >
      <div class="row full-width">
        <!-- XS SCREEN -->
        <div class="xs row full-width">
          <div class="col">
            <q-btn
            size="md"
            dense
            flat
            no-caps
            :label="$t('nav.cookies', 'Cookies')"
            icon="mdi-cookie"
            color="primary"
            @click="webConsentStore.triggerDialog()"
          />
          </div>
          <div class="col q-pt-xs">
            <router-link
              to="/legal"
              class="navbar-text-link q-pl-md"
              color="primary"
              >{{ $t("nav.legal", "Legal") }}</router-link
            >

            <router-link
              to="/about"
              class="navbar-text-link q-pl-md"
              color="primary"
              >{{ $t("nav.about", "About") }}</router-link
            >
          </div>
          <div class="col q-pt-xs  text-right text-primary ">
            <router-link to="/" class="navbar-text-link" color="primary"> &copy;2023 Ultri </router-link>
          </div>
        </div>

        <!-- LARGER THAN XS -->
        <div class="gt-xs row full-width">
          <q-btn
            size="md"
            dense
            flat
            no-caps
            :label="$t('nav.cookies', 'Cookies')"
            icon="mdi-cookie"
            color="primary"
            @click="webConsentStore.triggerDialog()"
          />
          <q-space />
          <div class="col q-pt-xs text-right">
            <router-link to="/legal" class="navbar-text-link" color="primary">{{
              $t("nav.legal", "Legal")
            }}</router-link>
            </div>
            <div class="col q-pt-xs  text-right">
            <router-link to="/about" class="navbar-text-link" color="primary">{{
              $t("nav.about", "About Ultri")
            }}</router-link>
            </div>
            <div class="col q-pt-xs text-right">
            <a
              href="https://www.linkedin.com/company/ultri/"
              class="navbar-text-link"
              >LinkedIn</a
            >
          </div>
          <div class="col q-pt-xs  text-right text-primary ">
            <router-link to="/" class="navbar-text-link" color="primary"> &copy;2023 Ultri </router-link>
          </div>
        </div>
      </div>
    </q-toolbar>
  </q-footer>
</template>

<script setup>
import { useRoute } from "vue-router";

import { useColorStore } from "../../stores/color";
import { useWebConsentStore } from "../../stores/webConsent";

// import CanvasAttribution from "../canvas/CanvasAttribution.vue";

const webConsentStore = useWebConsentStore();

const route = useRoute();

const canvasName = route.params.canvasName;

// Stores
const colorStore = useColorStore();
</script>

<style lang="scss"></style>
