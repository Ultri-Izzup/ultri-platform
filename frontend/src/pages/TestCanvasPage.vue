<template>
  <q-page class="">
    <component :is="currentComponent"></component>
  </q-page>
</template>

<script setup>
// Import computed
import { ref, computed } from "vue";
// Import useRoute composable
import { useRoute} from "vue-router";

// Import the canvas components
import BusinessCanvas from "../components/BusinessCanvas.vue";
import CoopCanvas from "../components/CoopCanvas.vue";

// Create a route instance
const route = useRoute();
// Get the canvasName from the route params
const canvasName = route.params.canvasName;

// Define a mapping of canvas names to their respective component name 
const canvases = {
  business: BusinessCanvas,
  coop: CoopCanvas,
};

// Use the current canvasName to find the mapped component
const currentComponent = computed(() => canvases[canvasName])
</script>