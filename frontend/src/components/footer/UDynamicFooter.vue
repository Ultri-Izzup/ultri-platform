<template>
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
</template>

<script setup>
import { useRoute } from "vue-router";

import { useColorStore } from "../../stores/color";

const route = useRoute();

// Stores
const colorStore = useColorStore();

</script>

<style lang="scss">

</style>
