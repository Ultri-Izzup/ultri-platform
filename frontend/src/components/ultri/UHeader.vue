<template>
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
