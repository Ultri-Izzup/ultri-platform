<template>
  <div>
    <CanvasList v-if="!canvasName"></CanvasList>
    <component :is="currentComponent" />
    <q-page-sticky
      :position="Screen.gt.sm ? 'bottom-right' : 'bottom'"
      :offset="fabPos"
      class="ontop"
    >
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

// Import stores
import { useCanvasStore } from "../stores/canvas";

import { Screen } from "quasar";

// Import the individual canvas SFC module
import CanvasEditor from "../components/canvas/CanvasEditor.vue";
import CanvasRenderer from "../components/canvas/CanvasRenderer.vue";
import UploadCanvasDialog from "../components/canvas/dialog/UploadCanvasDialog.vue";

// Instantiate our stores early so they are available
const canvasStore = useCanvasStore();

// FAB - Floating Action Button to save/download
const fabPos = ref([18, 18]);
const draggingFab = ref(false);

const displayUpload = ref(false);

const onUploadClick = () => {
  console.log("Upload Data for Current Canvas");
  // Display dialog
  displayUpload.value = true;
};
const onDeleteClick = () => {
  console.log("Delete All Data for Current Canvas");
  canvasStore.clearCanvas('currentCanvas');
};
const onDownloadClick = () => {
  console.log("Download Data for Current Canvas");

  // Get the canvas sections one at a time
  const canvasProps = Object.entries(canvasStore.currentCanvas);

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
