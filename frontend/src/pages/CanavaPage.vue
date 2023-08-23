<template>
  <div>
    <div class="row full-width ">
      <q-toolbar class="col-6">
        <span class="gt-md text-body1">Canvas data:</span>
        <q-btn
          @click="onDownloadClick()"
          color="primary"
          icon="mdi-download"
          class="q-ml-md"
          size="md"
          dense
          ><q-tooltip> Download </q-tooltip></q-btn
        >
        <q-btn
          @click="onUploadClick"
          color="primary"
          icon="mdi-upload"
          class="q-ml-md"
          size="md"
          dense
          ><q-tooltip> Upload </q-tooltip></q-btn
        >
        <q-btn
          @click="onDeleteClick()"
          color="secondary"
          icon="mdi-delete"
          class="q-ml-md"
          size="md"
          dense
          ><q-tooltip> Delete </q-tooltip></q-btn
        >
      </q-toolbar>
      <q-toolbar v-if="editorMode" class="col-12 col-md-6">
        <div class="text-body1 gt-md q-pl-lg q-pr-sm col-2">Template:</div>

        <div class="q-pl-md col">
          <q-select
            label="Canvas Template"
            v-model="selectedCanvas"
            :options="canvasOpts"
            @update:model-value="loadCanvasTemplate()"
          ></q-select>
        </div>
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
      v-if="editorMode"
    >
      <q-tab name="edit" label="Canvas View"> </q-tab>
      <q-tab name="create" label="Configure Canvas"> </q-tab>
    </q-tabs>
    <q-tab-panels v-model="tab" animated>
      <q-tab-panel name="create">
        <CanavaCreator v-model="canavaStore.canvasData"></CanavaCreator
      ></q-tab-panel>
      <q-tab-panel name="edit"
        ><CanavaEditor v-model="canavaStore.canvasData"></CanavaEditor
      ></q-tab-panel>
    </q-tab-panels>
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

import { useRoute } from "vue-router";

// Import stores
import { useCanavaStore } from "../stores/canava";

import { Screen } from "quasar";

// Import the individual canvas SFC module
import CanavaEditor from "../components/canava/CanavaEditor.vue";
import CanavaCreator from "../components/canava/CanavaCreator.vue";
import UploadCanavaDialog from "../components/canava/dialog/UploadCanavaDialog.vue";

import businessModelData from "../data/canava/businessModel.json";
import s3DelegationData from "../data/canava/s3Delegation.json";
import s3OrganizationData from "../data/canava/s3Organization.json";
import coopOwnershipData from "../data/canava/coopOwnership.json";

// Create i18n accessor as t
const { t } = useI18n();

const route = useRoute();

const editorMode = ref(true);

const canavaStore = useCanavaStore();

const canvasData = ref({ name: "", sections: [] });
const selectedCanvas = ref(null);
const displayUpload = ref(false);
const tab = ref("edit");

const canvasMap = {
  businessModel: businessModelData,
  s3Delegation: s3DelegationData,
  s3Organization: s3OrganizationData,
  coopOwnership: coopOwnershipData,
};

const loadCanvasTemplate = () => {
  console.log(selectedCanvas.value.value);

  const templateData = canvasMap[selectedCanvas.value.value];

  canavaStore.canvasData = templateData;
};

watch(
  () => route.params.canvasTemplate,
  () => {
    if (route.params.canvasTemplate) {
      editorMode.value = false;
      tab.value = 'edit';
      const templateData = canvasMap[route.params.canvasTemplate];
      canavaStore.canvasData = templateData;
    } else {
      editorMode.value = true;
    }
  },
  { immediate: true }
);

const importUpload = (data) => {
  data.sections.sort(
    (a, b) =>
      a.gridRow.localeCompare(b.gridRow) ||
      a.gridColumn.localeCompare(b.gridColumn)
  );
  canavaStore.canvasData = data;
};

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
  {
    label: "Co-op Ownership Model",
    value: "coopOwnership",
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
  canavaStore.$reset();
  selectedCanvas.value = null;
  tab.value = "edit";
  displayUpload.value = false;
};
const onDownloadClick = () => {
  console.log("Download Data for Current Canvas");

  // Define an object to hold our ouput
  const outObj = {
    name: canavaStore.canvasData.name,
    sections: canavaStore.canvasData.sections,
    sequenced: canavaStore.canvasData.sequenced ? true : false,
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
</script>

<style lang="scss">
</style>
