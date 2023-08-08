<template>
  <q-header :class="colorStore.darkMode ? 'u-navbar-dark' : 'u-navbar-light'">
    <q-toolbar>
      <q-btn
        flat
        dense
        round
        icon="mdi-menu"
        aria-label="Menu"
        @click="emit('toggleDrawer')"
      />
      <u-toolbar-title />
      <q-space></q-space>
      <u-toolbar-controls />
    </q-toolbar>
  </q-header>
</template>

<script setup>
import { useColorStore } from "../../stores/color";

import UToolbarTitle from "../../components/ultri/UToolbarTitle.vue";
import UToolbarControls from "../../components/ultri/UToolbarControls.vue";

const emit = defineEmits(['toggleDrawer'])

// Stores
const colorStore = useColorStore();
</script>

<style lang="scss">
</style>
