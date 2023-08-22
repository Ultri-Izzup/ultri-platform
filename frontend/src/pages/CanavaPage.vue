<template>
  <div>
    <div>
      <q-toolbar class="q-px-lg q-pb-md">
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
        <span class="text-h6 q-pl-md">Template:</span>
        <q-select
          label="Selected Canvas"
          v-model="selectedCanvas"
          :options="canvasOpts"
          class="q-ml-sm"
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
    <UploadCanavaDialog v-model="displayUpload" @uploaded="(event) => importUpload(event)"></UploadCanavaDialog>
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

const canvasData = ref({name: "", sections: []});
const selectedCanvas = ref(null);
const displayUpload = ref(false);

const devData = {
  "name": "S3 Delegation Canvas",
  "sections": [
    {
      "title": "Purpose",
      "instructions": "What purpose does the team (or role) serve in the organization?",
      "sectionKey": "purpose",
      "gridColumn": "1/6",
      "gridRow": "1/4"
    },
    {
      "title": "Key Resources",
      "instructions": "What are essential resources the delegatee(s) can make use of?",
      "sectionKey": "resources",
      "gridColumn": "9/13",
      "gridRow": "1/4"
    },
    {
      "title": "Key Challenges",
      "instructions": "What are the three most important known (or anticipated) challenges the delegatee(s) might face?",
      "sectionKey": "challenges",
      "gridColumn": "6/9",
      "gridRow": "1/5"
    },
    {
      "title": "Key responsibilities",
      "instructions": "What are the delegatee’s main responsibilities, i.e. objectives, or essential work and decision making being delegated?",
      "sectionKey": "responsibilities",
      "gridColumn": "1/6",
      "gridRow": "4/7"
    },
    {
      "title": "Delegator Responsibilities",
      "instructions": "What is the delegator’s contribution to the success of the delegatee(s)?",
      "sectionKey": "delegator",
      "gridColumn": "9/13",
      "gridRow": "4/7"
    },
    {
      "title": " Key Deliverables",
      "instructions": "What does the team/role provide to achieve its purpose and meet the key responsibilities and key challenges?",
      "sectionKey": "deliverables",
      "gridColumn": "6/9",
      "gridRow": "5/9"
    },
    {
      "title": "Dependencies",
      "instructions": "What are the essential dependencies between this domain and other parts of the organization?",
      "sectionKey": "dependencies",
      "gridColumn": "1/6",
      "gridRow": "7/10"
    },
    {
      "title": "Key Metrics",
      "instructions": "What are the critical indicators of progress, project health or performance?",
      "sectionKey": "metrics",
      "gridColumn": "9/13",
      "gridRow": "7/10"
    },
    {
      "title": "Competencies, qualities and skills",
      "instructions": "What competencies, qualities and skills are required – or at least preferable – to successfully achieve the purpose of this domain?",
      "sectionKey": "competencies",
      "gridColumn": "6/9",
      "gridRow": "9/13"
    },
    {
      "title": "External Constraints",
      "instructions": "What are important external constraints to the autonomy and influence of the delegatee(s)?",
      "sectionKey": "constraints",
      "gridColumn": "1/6",
      "gridRow": "10/13"
    },
    {
      "title": "Monitoring and Evaluation",
      "instructions": "How will you monitor the key metrics, and when (and how) will you evaluate success of the team/role?",
      "sectionKey": "monitoring",
      "gridColumn": "9/13",
      "gridRow": "10/13"
    }
  ],
  "sequenced": false,
  "canavaVers": "1.0.0"
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
}

// Instantiate our stores early so they are available
//const canvasStore = useCanvasStore();

// FAB - Floating Action Button to save/download
const fabPos = ref([18, 18]);
const draggingFab = ref(false);

const tab = ref("edit");

const canvasOpts = [
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
  reset()
};
const reset = () => {
  canvasData.value = {name: "", sections: []};
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
    canavaVers: '1.0.0'
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
