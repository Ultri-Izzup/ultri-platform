<template>
  <div>
    <CanvasList v-if="!canvasName"></CanvasList>
    <component :is="currentComponent" />
    <q-page-sticky position="bottom-right" :offset="fabPos" class="ontop">
      <q-fab
        v-if="canvasName"
        icon="mdi-file-arrow-up-down-outline"
        direction="up"
        color="accent"
        :disable="draggingFab"
        v-touch-pan.prevent.mouse="moveFab"
        class="ontop"
      >
        <q-fab-action
          @click="onDownloadClick()"
          color="primary"
          icon="mdi-download"
          :disable="draggingFab"
          class="ontop"
        ></q-fab-action>
        <q-fab-action
          @click="onUploadClick"
          color="primary"
          icon="mdi-upload"
          :disable="draggingFab"
          class="ontop"
        ></q-fab-action>
        <q-fab-action
          @click="onDeleteClick()"
          color="secondary"
          icon="mdi-delete"
          :disable="draggingFab"
          class="ontop"
        ></q-fab-action>
      </q-fab>
    </q-page-sticky>
    <a id="downloadAnchorElem" style="display: none"></a>
    <UploadCanvasDialog v-model="displayUpload"></UploadCanvasDialog>
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
import S3OrganizationCanvas from "../components/canvas/S3OrganizationCanvas.vue";
import S3DelegationCanvas from "../components/canvas/S3DelegationCanvas.vue";
import S3TeamCanvas from "../components/canvas/S3TeamCanvas.vue";
import LeanCanvas from "../components/canvas/LeanCanvas.vue";
import CanvasList from "../components/canvas/CanvasList.vue";
import UploadCanvasDialog from "../components/canvas/dialog/UploadCanvasDialog.vue";


// Define a mapping of canvas names to their respective component name
const canvases = {
  business: BusinessCanvas,
  coop: CoopCanvas,
  "s3-organization": S3OrganizationCanvas,
  "s3-delegation": S3DelegationCanvas,
  "s3-team": S3TeamCanvas,
  lean: LeanCanvas
};

// Instantiate our stores early so they are available
const canvasStore = useCanvasStore();

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
    } else {
      canvasName.value = null;
    }
  },
  { immediate: true } // Makes it take effect on first load
);

// Use the current canvasName to find the mapped component
const currentComponent = computed(() => canvases[canvasName.value]);

// FAB - Floating Action Button to save/download
const fabPos = ref([18, 18]);
const draggingFab = ref(false);

const displayUpload = ref(false);

const onUploadClick = () => {
  console.log("Upload Data for " + canvasName.value);
  // Display dialog
  displayUpload.value = true;
}
const onDeleteClick = () => {
  console.log("Delete All Data for " + canvasName.value);
  canvasStore.clearCanvas(canvasName.value)
}
const onDownloadClick = () => {
  console.log("Download Data for " + canvasName.value);

  // Get the canvas sections one at a time
  const canvasProps = Object.entries(canvasStore[canvasName.value]);

  // Define an object to hold our ouput
  const outObj = { canvas: {} };

  outObj["canvas"][canvasName.value] = {};

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
          console.log(item);
          itemArray.push(item);
        });
        outVal = itemArray;
      }
    }

    outObj["canvas"][canvasName.value][sectionName] = outVal;
  });

  var dataStr =
    "data:text/json;charset=utf-8," +
    encodeURIComponent(JSON.stringify(outObj, 0, 2));
  var dlAnchorElem = document.getElementById("downloadAnchorElem");
  dlAnchorElem.setAttribute("href", dataStr);
  dlAnchorElem.setAttribute("download", canvasName.value + "-canvas.json");
  dlAnchorElem.click();

  console.log(outObj);
};
const moveFab = (ev) => {
  draggingFab.value = ev.isFirst !== true && ev.isFinal !== true;
  fabPos.value = [fabPos.value[0] - ev.delta.x, fabPos.value[1] - ev.delta.y];
};
</script>

<style lang="scss">
.ontop {
  z-index: 3;
}
</style>
