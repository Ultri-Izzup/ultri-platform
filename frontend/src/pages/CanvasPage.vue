<template>
  <div>
    <CanvasList v-if="!canvasName"></CanvasList>
    <component :is="currentComponent" />
    <q-page-sticky position="bottom-right" :offset="fabPos">
      <q-fab
        v-if="canvasName"
        icon="mdi-download"
        direction="up"
        color="accent"
        :disable="draggingFab"
        v-touch-pan.prevent.mouse="moveFab"
        @click="onDownloadClick()"
      />
    </q-page-sticky>
    <a id="downloadAnchorElem" style="display:none"></a>
  </div>
</template>

<script setup>
// Import major 3rd party modules, in rough order of precedence
import { ref, computed, watch, isProxy, toRaw } from "vue";
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
  let mok = nanoid();
  mockPartners.set(mok, { uid: mok, text: "Start.coop" });
  mok = nanoid();
  mockPartners.set(mok, { uid: mok, text: "NLnet" });

  const mockActivities = new Map();
  mok = nanoid();
  mockActivities.set(mok, { uid: mok, text: "Sell stuff" });
  mok = nanoid();
  mockActivities.set(mok, { uid: mok, text: "Make cool code" });

  canvas.setCanvasData("business", "partners", mockPartners);
  canvas.setCanvasData("business", "activities", mockActivities);
}

// FAB - Floating Action Button to save/download
const fabPos = ref([18, 18]);
const draggingFab = ref(false);
const onDownloadClick = () => {
  console.log("Download Data for " + canvasName.value);

  // Get the canvas sections one at a time
  const canvasProps = Object.entries(canvas[canvasName.value]);

  // Define an object to hold our ouput
  const outObj = {canvas: {} };

  outObj['canvas'][canvasName.value] = {}

  canvasProps.forEach((section) => {
    let outVal = [];
    console.log(section);
    // The first element is the section name
    const sectionName = section[0];

    // The second element is the data
    const sectionData = section[1];

    let rawData;

    if (isProxy(sectionData)) {
      rawData = toRaw(sectionData);
      if (rawData instanceof Map) {
        let itemArray = [];
        console.log("Converting Map to array", rawData);
        rawData.forEach((item) => {
          console.log(item)
          itemArray.push(item)
        })
        outVal = itemArray;
      }
    }

    outObj['canvas'][canvasName.value][sectionName] = outVal;

  });

  var dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(outObj, 0, 2));
  console.log(dataStr)
  var dlAnchorElem = document.getElementById('downloadAnchorElem');
  dlAnchorElem.setAttribute("href", dataStr);
  dlAnchorElem.setAttribute("download", "canvas.json");
  dlAnchorElem.click();

  console.log(outObj);
};
const moveFab = (ev) => {
  draggingFab.value = ev.isFirst !== true && ev.isFinal !== true;
  fabPos.value = [fabPos.value[0] - ev.delta.x, fabPos.value[1] - ev.delta.y];
};

</script>

<style lang="scss">
//display grid
</style>
