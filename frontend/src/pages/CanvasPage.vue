<template>
  <div>
    <CanvasList />
    <component :is="currentComponent" />
  </div>
</template>

<script setup>
// Import major 3rd party modules, in rough order of precedence
import { ref, computed, watch } from "vue";
import { useRoute } from "vue-router";

// Import stores
import { useCanvasStore } from "../stores/canvas";

// Import the individual canvas SFC module
import BusinessCanvas from "../components/canvas/BusinessCanvas.vue";
import CoopCanvas from "../components/canvas/CoopCanvas.vue";
import S3Canvas from "../components/canvas/S3Canvas.vue";
import CanvasList from "../components/canvas/CanvasList.vue";

// Remove when test data is removed
import { nanoid } from "nanoid";

// Define a mapping of canvas names to their respective component name
const canvases = {
  business: BusinessCanvas,
  coop: CoopCanvas,
  s3: S3Canvas,
};

// Instantiate our stores early so they are available
const canvas = useCanvasStore();

// Create a route instance
const route = useRoute();

// Create a ref for the canvasName
const canvasName = ref();

// Watch route and update canvas name as needed
watch(
  () => route.params.canvasName,
  () => {
    if (route.params.canvasName) {
      canvasName.value = route.params.canvasName;
    }
  },
  { immediate: true } // Makes it take effect on first load
);

// Use the current canvasName to find the mapped component
const currentComponent = computed(() => canvases[canvasName.value]);

// The canvases display has two modes:
// 1. Standalone, the page doesn't have an orgId available, provides a fresh page with no data.
// 2. Integrated, there is an orgUid in the URL and we load existing canvas data for the org.
//    We want to lazy load the canvas data, so we load only what is needed.
// We only need to load data when a specific canvas is defined.
if (canvasName.value && route.params.orgUid) {
  // Fetch the org canvas into the store
  // canvas.loadCanvas(canvasName.value, route.params.orgUid)
  console.log("Loading fake data for: " + route.params.orgUid);
  const mockPartners = new Map();
  mockPartners.set("abcdef", { uid: "abcdef", text: "Start.coop" });
  mockPartners.set("bcdefg", { uid: "bcdefg", text: "NLnet" });
  canvas.setCanvasData("business", mockPartners);
}
</script>

<style lang="scss">
//display grid
</style>
