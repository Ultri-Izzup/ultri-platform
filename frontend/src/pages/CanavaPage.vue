<template>
  <div>
    <CanvasEditor v-model="canvasData"></CanvasEditor>
    <br />
    <CanvasRenderer v-model="canvasData"></CanvasRenderer>
    <q-page-sticky
      :position="Screen.gt.sm ? 'bottom-right' : 'bottom'"
      :offset="fabPos"
      class="ontop"
    >
      <q-fab
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

import { useI18n } from "vue-i18n";

// Import stores
import { useCanvasStore } from "../stores/canvas";

import { Screen } from "quasar";

// Import the individual canvas SFC module
import CanvasEditor from "../components/canvas/CanvasEditor.vue";
import CanvasRenderer from "../components/canvas/CanvasRenderer.vue";
import UploadCanvasDialog from "../components/canvas/dialog/UploadCanvasDialog.vue";

// Create i18n accessor as t
const { t } = useI18n();

const canvasData = ref({});

const devData = {
  name: "Custom Canvas",
  sections: [
    {
      title: t("canvas.s3.organization.drivers.title"),
      instructions: t("canvas.s3.organization.drivers.instructions"),
      class: "drivers",
      sectionKey: "drivers",
      id: 1,
      gridColumn: "1/4",
      gridRow: "1/3",
    },
    {
      title: t("canvas.s3.organization.deliverables.title"),
      instructions: t("canvas.s3.organization.deliverables.instructions"),
      class: "deliverables",
      sectionKey: "deliverables",
      id: 2,
      gridColumn: "4/7",
      gridRow: "1/3",
    },
    {
      title: t("canvas.s3.organization.customer.title"),
      instructions: t("canvas.s3.organization.customer.instructions"),
      class: "customer",
      sectionKey: "customer",
      id: 3,
      gridColumn: "7/10",
      gridRow: "1/3",
    },
    {
      title: t("canvas.s3.organization.proposition.title"),
      instructions: t("canvas.s3.organization.proposition.instructions"),
      class: "proposition",
      sectionKey: "proposition",
      id: 4,
      gridColumn: "10/13",
      gridRow: "1/3",
    },
    {
      title: t("canvas.s3.organization.challenges.title"),
      instructions: t("canvas.s3.organization.challenges.instructions"),
      class: "challenges",
      sectionKey: "challenges",
      id: 5,
      gridColumn: "1/4",
      gridRow: "3/5",
    },
    {
      title: t("canvas.s3.organization.channels.title"),
      instructions: t("canvas.s3.organization.channels.instructions"),
      class: "channels",
      sectionKey: "channels",
      id: 6,
      gridColumn: "4/7",
      gridRow: "3/5",
    },
    {
      title: t("canvas.s3.organization.resources.title"),
      instructions: t("canvas.s3.organization.resources.instructions"),
      class: "resources",
      sectionKey: "resources",
      id: 7,
      gridColumn: "7/10",
      gridRow: "3/5",
    },
    {
      title: t("canvas.s3.organization.partners.title"),
      instructions: t("canvas.s3.organization.partners.instructions"),
      class: "partners",
      sectionKey: "partners",
      id: 8,
      gridColumn: "10/13",
      gridRow: "3/5",
    },
    {
      title: t("canvas.s3.organization.values.title"),
      instructions: t("canvas.s3.organization.values.instructions"),
      class: "values",
      sectionKey: "values",
      id: 9,
      gridColumn: "1/7",
      gridRow: "5/7",
    },
    {
      title: t("canvas.s3.organization.metrics.title"),
      instructions: t("canvas.s3.organization.metrics.instructions"),
      class: "metrics",
      sectionKey: "metrics",
      id: 10,
      gridColumn: "7/13",
      gridRow: "5/7",
    },
    {
      title: t("canvas.s3.organization.cost.title"),
      instructions: t("canvas.s3.organization.cost.instructions"),
      class: "cost",
      sectionKey: "cost",
      id: 11,
      gridColumn: "1/7",
      gridRow: "7/8",
    },
    {
      title: t("canvas.s3.organization.revenue.title"),
      instructions: t("canvas.s3.organization.revenue.instructions"),
      class: "revenue",
      sectionKey: "revenue",
      id: 12,
      gridColumn: "7/13",
      gridRow: "7/8",
    },
  ],
};

canvasData.value = devData;

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
  canvasStore.clearCanvas("currentCanvas");
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
