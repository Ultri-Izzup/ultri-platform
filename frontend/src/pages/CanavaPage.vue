<template>
  <div>
    <div>
      <q-toolbar class="q-px-lg q-pb-md row">
        <span class="text-h6">Canvas data:</span>
        <q-btn
          @click="onDownloadClick()"
          color="primary"
          icon="mdi-download"
          class="q-ml-md"
          ><q-tooltip> Download </q-tooltip></q-btn
        >
        <q-btn
          @click="onUploadClick"
          color="primary"
          icon="mdi-upload"
          class="q-ml-md"
          ><q-tooltip> Upload </q-tooltip></q-btn
        >
        <q-btn
          @click="onDeleteClick()"
          color="secondary"
          icon="mdi-delete"
          class="q-ml-md"
          ><q-tooltip> Delete </q-tooltip></q-btn
        >

          <div class="text-h6 q-px-md col-1">Template:</div>
          <q-select
            label="Select Canvas"
            v-model="selectedCanvas"
            :options="canvasOpts"
            class="q-pl-md col-2"
          ></q-select>

      </q-toolbar>
    </div>
    <!-- <pre>{{canvasData}}</pre> -->
    <q-tabs
      v-model="tab"
      dense
      class="text-grey-9"
      active-color="primary"
      indicator-color="primary"
      align="justify"
    >
      <q-tab name="edit" label="Canvas View"> </q-tab>
      <q-tab name="create" label="Configure Canvas"> </q-tab>
    </q-tabs>
    <q-tab-panels v-model="tab" animated>
      <q-tab-panel name="create">
        <CanavaCreator v-model="canvasData"></CanavaCreator
      ></q-tab-panel>
      <q-tab-panel name="edit"
        ><CanavaEditor v-model="canvasData"></CanavaEditor
      ></q-tab-panel>
    </q-tab-panels>

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
    <UploadCanavaDialog
      v-model="displayUpload"
      @uploaded="(event) => importUpload(event)"
    ></UploadCanavaDialog>
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
import CanavaEditor from "../components/canava/CanavaEditor.vue";
import CanavaCreator from "../components/canava/CanavaCreator.vue";
import UploadCanavaDialog from "../components/canava/dialog/UploadCanavaDialog.vue";

// Create i18n accessor as t
const { t } = useI18n();

const canvasData = ref({ name: "", sections: [] });
const selectedCanvas = ref(null);
const displayUpload = ref(false);

const devData = {
  name: "S3 Organization Canvas",
  sections: [
    {
      title: t("canvas.s3.organization.drivers.title"),
      instructions: t("canvas.s3.organization.drivers.instructions"),
      sectionKey: "drivers",
      gridColumn: "1/4",
      gridRow: "1/4",
      sequence: "1",
    },
    {
      title: t("canvas.s3.organization.deliverables.title"),
      instructions: t("canvas.s3.organization.deliverables.instructions"),
      sectionKey: "deliverables",
      gridColumn: "4/7",
      gridRow: "1/4",
      sequence: "2",
    },
    {
      title: t("canvas.s3.organization.customer.title"),
      instructions: t("canvas.s3.organization.customer.instructions"),
      sectionKey: "customer",
      gridColumn: "7/10",
      gridRow: "1/5",
      sequence: "3",
    },
    {
      title: t("canvas.s3.organization.proposition.title"),
      instructions: t("canvas.s3.organization.proposition.instructions"),
      sectionKey: "proposition",
      gridColumn: "10/13",
      gridRow: "1/3",
      sequence: "4",
    },
    {
      title: t("canvas.s3.organization.challenges.title"),
      instructions: t("canvas.s3.organization.challenges.instructions"),
      sectionKey: "challenges",
      gridColumn: "10/13",
      gridRow: "3/5",
      sequence: "5",
    },
    {
      title: t("canvas.s3.organization.partners.title"),
      instructions: t("canvas.s3.organization.partners.instructions"),
      sectionKey: "partners",
      gridColumn: "1/4",
      gridRow: "4/6",
      sequence: "8",
    },
    {
      title: t("canvas.s3.organization.resources.title"),
      instructions: t("canvas.s3.organization.resources.instructions"),
      sectionKey: "resources",
      gridColumn: "4/7",
      gridRow: "4/6",
      sequence: "7",
    },
    {
      title: t("canvas.s3.organization.channels.title"),
      instructions: t("canvas.s3.organization.channels.instructions"),
      sectionKey: "channels",
      gridColumn: "6/13",
      gridRow: "5/6",
      sequence: "6",
    },
    {
      title: t("canvas.s3.organization.metrics.title"),
      instructions: t("canvas.s3.organization.metrics.instructions"),
      sectionKey: "metrics",
      gridColumn: "1/6",
      gridRow: "6/7",
      sequence: "10",
    },
    {
      title: t("canvas.s3.organization.values.title"),
      instructions: t("canvas.s3.organization.values.instructions"),
      sectionKey: "values",
      gridColumn: "6/13",
      gridRow: "6/7",
      sequence: "9",
    },

    {
      title: t("canvas.s3.organization.cost.title"),
      instructions: t("canvas.s3.organization.cost.instructions"),
      sectionKey: "cost",
      gridColumn: "1/6",
      gridRow: "7/8",
      sequence: "11",
    },
    {
      title: t("canvas.s3.organization.revenue.title"),
      instructions: t("canvas.s3.organization.revenue.instructions"),
      sectionKey: "revenue",
      gridColumn: "6/13",
      gridRow: "7/8",
      sequence: "12",
    },
  ],
  sequenced: false,
  canavaVers: "1.0.0",
};

// Sort data so lowest row/col come first
devData.sections.sort(
  (a, b) =>
    a.gridRow.localeCompare(b.gridRow) ||
    a.gridColumn.localeCompare(b.gridColumn)
);
console.log(devData.sections);
canvasData.value = devData;

const importUpload = (data) => {
  data.sections.sort(
    (a, b) =>
      a.gridRow.localeCompare(b.gridRow) ||
      a.gridColumn.localeCompare(b.gridColumn)
  );
  canvasData.value = data;
};

// Instantiate our stores early so they are available
//const canvasStore = useCanvasStore();

// FAB - Floating Action Button to save/download
const fabPos = ref([18, 18]);
const draggingFab = ref(false);

const tab = ref("edit");

const canvasOpts = [
  {
    label: "Business Model Canvas",
    value: "businessModel",
  },
  {
    label: "S3 Organization Canvas",
    value: "s3Organization",
  },
  {
    label: "S3 Delegation Canvas",
    value: "s3Delegation",
  },
];

const onUploadClick = () => {
  console.log("Upload Data for Current Canvas");
  // Display dialog
  displayUpload.value = true;
};
const onDeleteClick = () => {
  console.log("Delete All Data for Current Canvas");
  reset();
};
const reset = () => {
  canvasData.value = { name: "", sections: [] };
  selectedCanvas.value = null;
  tab.value = "edit";
  displayUpload.value = false;
};
const onDownloadClick = () => {
  console.log("Download Data for Current Canvas");

  // Define an object to hold our ouput
  const outObj = {
    name: canvasData.value.name,
    sections: canvasData.value.sections,
    sequenced: canvasData.value.sequenced ? true : false,
    canavaVers: "1.0.0",
  };

  var dataStr =
    "data:text/json;charset=utf-8," +
    encodeURIComponent(JSON.stringify(outObj, 0, 2));
  var dlAnchorElem = document.getElementById("downloadAnchorElem");
  dlAnchorElem.setAttribute("href", dataStr);
  dlAnchorElem.setAttribute("download", "canvas.json");
  dlAnchorElem.click();
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
