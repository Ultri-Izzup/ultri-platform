<template>
  <div>
    <div class="row full-width q-pb-lg">
      <q-toolbar class="col-6">
        <span class="gt-md text-h6">Canvas data:</span>
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
      </q-toolbar>
      <q-toolbar class="col-12 col-md-6">
        <div class="text-h6 gt-md q-pl-lg q-pr-sm col-2">Template:</div>

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

import businessModelData from "../data/canava/businessModel.json";
import s3DelegationData from "../data/canava/s3Delegation.json";
import s3OrganizationData from "../data/canava/s3Organization.json";
import coopOwnershipData from "../data/canava/coopOwnership.json";

// Create i18n accessor as t
const { t } = useI18n();

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

  canvasData.value = templateData;
};

// const devData = {
//   name: "Co-op Ownership Canvas",
//   sections: [
//     {
//       title: t("canvas.coop.purpose.title"),
//       instructions: t("canvas.coop.purpose.instructions"),
//       sectionKey: "purpose",
//       gridColumn: "1/11",
//       gridRow: "1/2",
//       sequence: "1",
//     },

//     {
//       title: t("canvas.coop.stakeholders.title"),
//       instructions: t("canvas.coop.stakeholders.instructions"),
//       sectionKey: "stakeholders",
//       gridColumn: "1/3",
//       gridRow: "2/5",
//       sequence: "2",
//     },
//     {
//       title: t("canvas.coop.nonOwnerStakeholders.title"),
//       instructions: t("canvas.coop.nonOwnerStakeholders.instructions"),
//       sectionKey: "nonOwnerStakeholders",
//       gridColumn: "1/3",
//       gridRow: "5/7",
//       sequence: "2.1",
//     },
//     {
//       title: t("canvas.coop.benefits.title"),
//       instructions: t("canvas.coop.benefits.instructions"),
//       sectionKey: "benefits",
//       gridColumn: "3/5",
//       gridRow: "2/7",
//       sequence: "3",
//     },
//     {
//       title: t("canvas.coop.responsibilities.title"),
//       instructions: t("canvas.coop.responsibilities.instructions"),
//       sectionKey: "responsibilities",
//       gridColumn: "5/7",
//       gridRow: "2/7",
//       sequence: "4",
//     },
//     {
//       title: t("canvas.coop.governance.title"),
//       instructions: t("canvas.coop.governance.instructions"),
//       sectionKey: "governance",
//       gridColumn: "7/9",
//       gridRow: "2/7",
//       sequence: "6",
//     },
//     {
//       title: t("canvas.coop.financial.title"),
//       instructions: t("canvas.coop.financial.instructions"),
//       sectionKey: "financial",
//       gridColumn: "9/11",
//       gridRow: "2/7",
//       sequence: "7",
//     },

//     {
//       title: t("canvas.coop.guidance.title"),
//       instructions: t("canvas.coop.guidance.instructions"),
//       sectionKey: "guidance",
//       gridColumn: "1/6",
//       gridRow: "7/9",
//       sequence: "5",
//     },

//     {
//       title: t("canvas.coop.investment.title"),
//       instructions: t("canvas.coop.investment.instructions"),
//       sectionKey: "investment",
//       gridColumn: "6/11",
//       gridRow: "7/9",
//       sequence: "8",
//     },
//   ],
//   sequenced: true,
//   canavaVers: "1.0.0",
// };

// // Sort data so lowest row/col come first
// devData.sections.sort(
//   (a, b) =>
//     a.gridRow.localeCompare(b.gridRow) ||
//     a.gridColumn.localeCompare(b.gridColumn)
// );
// console.log(devData.sections);
// canvasData.value = devData;

const importUpload = (data) => {
  data.sections.sort(
    (a, b) =>
      a.gridRow.localeCompare(b.gridRow) ||
      a.gridColumn.localeCompare(b.gridColumn)
  );
  canvasData.value = data;
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
</script>

<style lang="scss">
</style>
