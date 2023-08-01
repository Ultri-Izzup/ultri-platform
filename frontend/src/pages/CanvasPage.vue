<template>
  <component :is="currentComponent" />
</template>

<script setup>
// Import major 3rd party modules, in rough order of precedence
import { ref, computed } from "vue";
import { useRoute} from "vue-router";

// Import the individual canvas SFC module
import BusinessCanvas from "../components/canvas/BusinessCanvas.vue";
import CoopCanvas from "../components/canvas/CoopCanvas.vue";
import S3Canvas from "../components/canvas/S3Canvas.vue";

// Define a mapping of canvas names to their respective component name
const canvases = {
  business: BusinessCanvas,
  coop: CoopCanvas,
  s3: S3Canvas,
};

// Create a route instance
const route = useRoute();
// Get the canvasName from the route params
const canvasName = route.params.canvasName;
// Use the current canvasName to find the mapped component
const currentComponent = computed(() => canvases[canvasName])

</script>

<style lang="scss">
//display grid
</style>
