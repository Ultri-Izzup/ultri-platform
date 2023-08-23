<template>
  <div>
    <q-btn to="/canava" dense round flat icon="mdi-cog-outline" size="sm"><q-tooltip>Configure</q-tooltip></q-btn>
    <CanavaEditor v-model="canavaStore.canvasData"></CanavaEditor>
  </div>
</template>

<script setup>
// Import stores
import { useCanavaStore } from "../stores/canava";

// Import the individual canvas SFC module
import CanavaEditor from "../components/canava/CanavaEditor.vue";

const canavaStore = useCanavaStore();

</script>

<style lang="scss">
</style>
