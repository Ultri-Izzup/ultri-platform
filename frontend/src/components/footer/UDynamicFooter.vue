<template>
  <q-footer>
    <q-toolbar
      :class="colorStore.darkMode ? 'u-navbar-dark' : 'u-navbar-light'"
    >
    <!-- CANVAS FOOTER w/ ATTRIBUTION -->
      <div v-if="route.name == 'canvasPage'" class="row full-width">
        <!-- XS SCREEN -->
        <div class="xs row full-width">
          <div class="col q-py-sm text-caption">
            {{ $t('canvas.'+canvasName+'.attribution', ' ')}}
          </div>
          <div class="col-2 q-py-sm text-right justify-right">
            <q-space /><a
              href="https://www.linkedin.com/company/ultri/"
              class="navbar-text-link"
              >LinkedIn</a
            >
            <q-space />
            <div class="text-body2">&copy; Ultri 2023</div>
          </div>
        </div>
        <!-- LARGER THAN XS -->
        <div class="gt-xs row full-width">
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
        </div>
      </div>
    <!-- STANDARD FOOTER -->
      <div v-else class="row full-width">
        <!-- XS SCREEN -->
        <div class="xs row full-width">
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
        </div>
        <!-- LARGER THAN XS -->
        <div class="gt-xs row full-width">
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
        </div>
      </div>

    </q-toolbar>
  </q-footer>
</template>

<script setup>
import { useRoute } from "vue-router";

import { useColorStore } from "../../stores/color";

const route = useRoute();

const canvasName = route.params.canvasName;

// Stores
const colorStore = useColorStore();
</script>

<style lang="scss">
</style>
