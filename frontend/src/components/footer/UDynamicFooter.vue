<template>
  <q-footer>
    <q-toolbar
      :class="colorStore.darkMode ? 'u-navbar-dark' : 'u-navbar-light'"
    >
      <!-- CANVAS FOOTER w/ ATTRIBUTION
      <div v-if="route.name == 'canvasPage'" class="row full-width">

        <div class="xs row full-width">
          <CanvasAttribution class="col-10" />
          <div class="col-2 q-py-sm text-right justify-right">
            <router-link to="/legal" class="navbar-text-link" color="primary">{{
              $t("nav.legal", "Legal")
            }}</router-link>
            <div class="text-body2">&copy; Ultri 2023</div>
          </div>
        </div>

        <div class="gt-xs row full-width">
          <div class="col q-py-sm text-caption">
            <CanvasAttribution class="col-10" />
          </div>
          <div class="text-body2 q-pr-md">
            <a
              href="https://www.linkedin.com/company/ultri/"
              class="navbar-text-link"
              >LinkedIn</a
            ><q-space></q-space> &copy; 2023 Ultri
          </div>
        </div>
      </div> -->

      <!-- STANDARD FOOTER -->
      <div class="row full-width">
        <!-- XS SCREEN -->
        <div class="xs row full-width">
          <div class="col">
            <router-link
              to="/legal/cookies"
              class="navbar-text-link"
              color="primary"
              >{{ $t("nav.cookies", "Cookies") }}</router-link
            >
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
          <div class="col text-right justify-right">
            <div>
              &copy;2023
              <span class="text-bold text-primary text-body1"> Ultri </span>
            </div>
          </div>
        </div>

        <!-- LARGER THAN XS -->
        <div class="gt-xs row full-width">
          <span class="q-pl-md">
            <router-link
              to="/legal/cookies"
              class="navbar-text-link"
              color="primary"
              >{{ $t("nav.cookies", "Cookies") }}</router-link
            >
          </span>
          <q-space />
          <router-link to="/legal" class="navbar-text-link" color="primary">{{
            $t("nav.legal", "Legal")
          }}</router-link>
          <q-space />
          <router-link to="/about" class="navbar-text-link" color="primary">{{
            $t("nav.about", "About Ultri")
          }}</router-link>
          <!-- <q-space /><a
            href="https://www.opensociocracy.org"
            class="navbar-text-link"
            >OpenSociocracy</a
          > -->
          <q-space /><a
            href="https://www.linkedin.com/company/ultri/"
            class="navbar-text-link"
            >LinkedIn</a
          >
          <q-space />
          <div>
            &copy;2023
            <span class="text-bold text-primary text-body1"> Ultri </span>
          </div>
        </div>
      </div>
    </q-toolbar>
  </q-footer>
</template>

<script setup>
import { useRoute } from "vue-router";

import { useColorStore } from "../../stores/color";

import CanvasAttribution from "../canvas/CanvasAttribution.vue";

const route = useRoute();

const canvasName = route.params.canvasName;

// Stores
const colorStore = useColorStore();
</script>

<style lang="scss"></style>
