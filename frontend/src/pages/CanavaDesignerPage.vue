<template>
  <div>
    <div class="row full-width q-pb-lg">
      <q-toolbar class="col-6">
        <span class="gt-md text-body1">Canvas data:</span>
        <q-btn
          @click="onDownloadClick(canvasTemplate)"
          color="primary"
          icon="mdi-download"
          class="q-ml-md"
          size="md"
          dense
          ><q-tooltip> Download </q-tooltip></q-btn
        >
        <q-btn
          @click="onDownloadClick('ALL')"
          color="primary"
          icon="mdi-download-multiple"
          class="q-ml-md"
          size="md"
          dense
          ><q-tooltip> All Canvas </q-tooltip></q-btn
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
          :disable="!showDeleteOpts"
          ><q-tooltip> Delete </q-tooltip></q-btn
        >

        <q-btn
          :to="canavaViewerRoute"
          color="secondary"
          icon="mdi-eye"
          class="q-ml-md"
          size="md"
          dense
          ><q-tooltip> View Canvas </q-tooltip></q-btn
        >


        <q-btn
          :disabled="!auth.isSignedIn"
          @click="saveToCloud(canvasTemplate)"
          icon="mdi-content-save"
          size="md"
          color="primary"
          class="q-ml-md"
          dense
          ><q-tooltip>
            {{
              auth.isSignedIn
                ? "Save canvas to cloud"
                : "Login to save to cloud"
            }}</q-tooltip
          ></q-btn
        >
        <q-btn
          :disabled="!auth.isSignedIn"
          @click="saveToCloud(canvasTemplate)"
          icon="mdi-content-save-all"
          size="md"
          color="primary"
          class="q-ml-md"
          dense
          ><q-tooltip>
            {{
              auth.isSignedIn
                ? "Save all data to cloud"
                : "Login to save to cloud"
            }}</q-tooltip
          ></q-btn
        >

      </q-toolbar>
      <q-toolbar v-if="showDeleteOpts" class="col-12 col-md-6">
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
    <q-separator />
    <!-- <span v-if="canvasTemplate">TEMPLATE DATA: {{canavaStore.storedCanvases[canvasTemplate]}}</span>
    <span v-if="!canvasTemplate">DESIGNER DATA: {{canavaStore.canvasData}}</span> -->
    <CanavaDesigner
      v-if="!canvasTemplate"
      v-model="canavaStore.canvasData"
      :canvasData="canavaStore.canvasData"
      :canvasOpts="canvasOpts"
    />
    <CanavaDesigner
      v-else
      v-model="canavaStore.storedCanvases[canvasTemplate]"
      :canvasOpts="canvasOpts"
    />

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

import { useRoute, useRouter } from "vue-router";

import { v4 as uuidv4 } from "uuid";

// Import stores
import { useAuthStore } from "../stores/auth";
import { useCanavaStore } from "../stores/canava";

// Import the individual canvas SFC module
import CanavaCreator from "../components/canava/CanavaCreator.vue";
import CanavaDesigner from "../components/canava/CanavaDesigner.vue";
import UploadCanavaDialog from "../components/canava/dialog/UploadCanavaDialog.vue";

import businessModelData from "../data/canava/businessModel.json";
import s3DelegationData from "../data/canava/s3Delegation.json";
import s3OrganizationData from "../data/canava/s3Organization.json";
import s3TeamData from "../data/canava/s3Team.json";
import coopOwnershipData from "../data/canava/coopOwnership.json";
import leanCanvasData from "../data/canava/leanCanvas.json";
import leanUXData from "../data/canava/leanUX.json";
import productVisionBoardData from "../data/canava/productVisionBoard.json";
import productVisionBoardExtData from "../data/canava/productVisionBoardExt.json";
import productCanvasData from "../data/canava/productCanvas.json";

// Create i18n accessor as t
const { t } = useI18n();

const route = useRoute();
const router = useRouter();

const auth = useAuthStore();
const canavaStore = useCanavaStore();

const canvasTemplate = ref(null);

const selectedCanvas = ref(null);
const displayUpload = ref(false);

const canavaViewerRoute = computed(() => {
  let viewerRoute = "";
  //console.log(route.name);
  switch (route.name) {
    case "canavaDesigner": {
      viewerRoute = "/canava/designer/view";
      break;
    }
    case "canavaTemplateDesigner": {
      viewerRoute = "/canava/template/" + route.params.canvasTemplate;
      break;
    }
    case "canavaCustomDesigner": {
      viewerRoute = "/canava/custom/" + route.params.canvasTemplate;
      break;
    }
  }
  return viewerRoute;
});

const showDeleteOpts = computed(() => {
  let shouldShow = true;
  switch (route.name) {
    case "canavaTemplateDesigner":
      shouldShow = false;
  }
  return shouldShow;
});

watch(
  () => route.params.canvasTemplate,
  (newTemplate) => {
    if (newTemplate) {
      // Load for default/custom or named template?
      switch (route.name) {
        case "canavaDesigner": {
          canavaStore.loadCanvasTemplate(newTemplate);
          break;
        }
        case "canavaTemplateDesigner": {
          canavaStore.loadTemplateCanvas(newTemplate);
          break;
        }
      }
      canvasTemplate.value = newTemplate;
    }
  },
  { immediate: true }
);

const canvasMap = {
  businessModel: businessModelData,
  s3Delegation: s3DelegationData,
  s3Organization: s3OrganizationData,
  s3Team: s3TeamData,
  coopOwnership: coopOwnershipData,
  leanCanvas: leanCanvasData,
  leanUX: leanUXData,
  productVisionBoard: productVisionBoardData,
  productVisionBoardExt: productVisionBoardExtData,
  productCanvas: productCanvasData,
};

const loadCanvasTemplate = () => {
  console.log(selectedCanvas.value.value);

  const templateData = canvasMap[selectedCanvas.value.value];

  templateData.sections.forEach(function (item, index) {
    if (!item.uid) {
      item.uid = uuidv4();
    }
    console.log(item, index);
  });

  canavaStore.canvasData = templateData;
};

const importUpload = (data) => {
  Object.entries(data.canvases).forEach(([key, value]) => {
    console.log(`${key} ${value}`); // "a 5", "b 7", "c 9"
    importUploadedCanvas(key, value);
  });
};

const importUploadedCanvas = (namespace, canvas) => {
  canvas.sections.sort(
    (a, b) =>
      a.gridRow.localeCompare(b.gridRow) ||
      a.gridColumn.localeCompare(b.gridColumn)
  );

  if (namespace === "custom") {
    canavaStore.canvasData = canvas;
  } else {
    canavaStore.storedCanvases[namespace] = canvas;
  }
};

const canvasOpts = canavaStore.canvasOpts;

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
  displayUpload.value = false;
};

const onDownloadClick = (targetCanvas = false) => {
  console.log("Download Data for " + targetCanvas);

  // Define canvasesobject
  let canvases = {};

  if (!targetCanvas) {
    canvases.custom = {
      name: canavaStore.canvasData.name,
      completedOn: canavaStore.canvasData.completedOn,
      completedBy: canavaStore.canvasData.completedBy,
      attribution: canavaStore.canvasData.attribution,
      version: canavaStore.canvasData.version,
      sections: canavaStore.canvasData.sections,
      sequenced: canavaStore.canvasData.sequenced ? true : false,
      canavaVers: "1.0.0",
    };
  } else if (targetCanvas === "ALL") {
    canvases = {
      ...canavaStore.storedCanvases,
      ...{
        custom: {
          name: canavaStore.canvasData.name,
          completedOn: canavaStore.canvasData.completedOn,
          completedBy: canavaStore.canvasData.completedBy,
          attribution: canavaStore.canvasData.attribution,
          version: canavaStore.canvasData.version,
          sections: canavaStore.canvasData.sections,
          sequenced: canavaStore.canvasData.sequenced ? true : false,
          canavaVers: "1.0.0",
        },
      },
    };
  } else {
    canvases[targetCanvas] = canavaStore.storedCanvases[targetCanvas];
  }

  var dataStr =
    "data:text/json;charset=utf-8," +
    encodeURIComponent(JSON.stringify({ canvases: canvases }, 0, 2));
  var dlAnchorElem = document.getElementById("downloadAnchorElem");
  dlAnchorElem.setAttribute("href", dataStr);
  dlAnchorElem.setAttribute("download", "canvas.json");
  dlAnchorElem.click();
};

const saveToCloud = (targetCanvas = false) => {
  console.log("Saving to cloud " + targetCanvas);

  // Loop through canvases
  // If the canvas prop is a uuid, it has already been stored in the cloud and we need to update that record
  //
  // If the canvas prop is an expected string:
  //     1. make the canvas origin a prop on the canvas
  //     2. replace with a uuid and store as a new canvas

  // Define canvasesobject
  let canvas = {};

  if (!targetCanvas) {
    // If no target defined, use the custom canvas from designer.
    // We know this doesn't have a `uuid` as the `uid` yet.
    console.log('SAVING DESIGNER CANVAS')
    const newUuid = uuidv4();
    canvas = canavaStore.canvasData;
    canvas.uid = newUuid;

    // @TODO - POST CANVAS TO API

    // Save the canvas to the storedCanvases
    canavaStore.storedCanvases[newUuid] = canvas;

    // Clear the designer canvas data
    canavaStore.resetCanvasData();

    // Push the client to the saved canvas route
    router.push({name: 'canavaTemplateViewer', params: {canvasTemplate: newUuid}})

  } else if (targetCanvas === "ALL") {
    // Store in cloud every canvas we have stored locally
    console.log('ALL CANVAS')

  } else {
    // Store this one particular canvas in the cloud
    console.log('THIS CANVAS',  targetCanvas)
    console.log(canavaStore.storedCanvases[targetCanvas])
    const canvas = canavaStore.storedCanvases[targetCanvas]


    // @TODO - POST CANVAS TO API

    // Save the canvas to the storedCanvases
    canavaStore.storedCanvases[newUuid] = canvas;

    // Clear the old template data
    delete canavaStore.storedCanvases[targetCanvas];

    // Push the client to the saved canvas route
    router.push({name: 'canavaTemplate', params: {canvasTemplate: newUuid}})
  }

  //console.log("Saving to cloud...", canvases);
};
</script>

<style lang="scss"></style>
