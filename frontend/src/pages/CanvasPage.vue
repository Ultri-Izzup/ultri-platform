<template>
  <div>
    <component :is="currentComponent" :currentData="canvas[canvasName]" />
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

// @TODO Call store to load existing data
//Add some data to store for now, we shoule create a methods vs. mutating the store data directly

const mockData = {
  partners: [
    {
      uid: nanoid(),
      memberUid: "fsdfsfs",
      text: "First Business Partner entry",
    },
    {
      uid: nanoid(),
      memberUid: "gthrhty",
      text: "Second Business Partner entry",
    },
  ],
  channels: [
  { uid: nanoid(), memberUid: "fsdfsfs", text: "First Business channel entry" },
  {
    uid: nanoid(),
    memberUid: "gthrhty",
    text: "Second Business channel entry",
  },
]
};


canvas.setCanvasData("business", mockData);

</script>

<style lang="scss">
//display grid
</style>
