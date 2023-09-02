<template>
  <div>
    <q-btn
      :to="canvasConfigRoute"
      dense
      round
      flat
      icon="mdi-cog-outline"
      size="sm"
      ><q-tooltip>Configure</q-tooltip></q-btn
    >
    <q-btn
      @click="onDownloadClick(canvasTemplate)"
      icon="mdi-download"
      size="sm"
      dense
      flat
      round
      ><q-tooltip> Download </q-tooltip></q-btn
    >
    <q-btn
      :disabled="!auth.isSignedIn"
      @click="saveToCloud(canvasTemplate)"
      icon="mdi-content-save"
      size="sm"
      dense
      flat
      round
      ><q-tooltip> {{ auth.isSignedIn ? 'Save canvas' : 'Sign in to save' }}</q-tooltip></q-btn
    >
    <!-- <q-btn
      :disabled="!auth.isSignedIn"
      @click="saveToCloud(canvasTemplate)"
      icon="mdi-content-save-all"
      size="sm"
      dense
      flat
      round
      ><q-tooltip> {{ auth.isSignedIn ? 'Save all data to cloud' : 'Login to save to cloud' }}</q-tooltip></q-btn
    > -->
    <!-- <pre>TEMPLATE {{canvasTemplate}} TEMPLATECANVASES{{canavaStore.storedCanvases}} </pre> -->
    <!-- <span v-if="canvasTemplate">TEMPLATE DATA: {{canavaStore.storedCanvases[canvasTemplate]}}</span>
    <span v-if="!canvasTemplate">DESIGNER DATA: {{canavaStore.canvasData}}</span> -->
    <CanavaViewer
      v-if="!canvasTemplate"
      v-model="canavaStore.canvasData"
      :canvasOpts="canavaStore.canvasOpts"
      @canvasSelected="(event) => canavaStore.loadCanvasTemplate(event)"
    ></CanavaViewer>
    <CanavaViewer
      v-else
      v-model="canavaStore.storedCanvases[canvasTemplate]"
      @canvasSelected="(event) => canavaStore.loadCanvasTemplate(event)"
    ></CanavaViewer>
    <a id="downloadAnchorElem" style="display: none"></a>
  </div>
</template>

<script setup>
import { ref, watch, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { v4 as uuidv4 } from "uuid";

// Import stores
import { useAuthStore } from "../stores/auth";
import { useCanavaStore } from "../stores/canava";


// Import the individual canvas SFC module
import CanavaViewer from "../components/canava/CanavaViewer.vue";

const auth = useAuthStore();
const canavaStore = useCanavaStore();

const canvasTemplate = ref(null);

const route = useRoute();
const router = useRouter();

const canvasConfigRoute = computed(() => {
  let configRoute = "";
  switch (route.name) {
    case "canavaDesignerViewer": {
      configRoute = "/canava/designer";
      break;
    }
    case "canavaTemplate": {
      configRoute =
        "/canava/template/" + route.params.canvasTemplate + "/designer";
      break;
    }
    case "canavaCustomViewer": {
      configRoute =
        "/canava/custom/" + route.params.canvasTemplate + "/designer";
      break;
    }
  }
  return configRoute;
});

watch(
  () => route.params.canvasTemplate,
  (newTemplate) => {
    if (newTemplate) {
      // Load for default/custom or named template?
      switch (route.name) {
        case "canavaDesignerViewer": {
          canavaStore.loadCanvasTemplate(newTemplate);
          break;
        }
        case "canavaTemplate": {
          canavaStore.loadTemplateCanvas(newTemplate);
          break;
        }
      }
      canvasTemplate.value = newTemplate;
    }
  },
  { immediate: true }
);

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
    const newUuid = canavaStore.saveDesignerCanvas()

    // Push the client to the saved canvas route
    router.push({name: 'canavaTemplate', params: {canvasTemplate: newUuid}})

  } else if (targetCanvas === "ALL") {
    // Store in cloud every canvas we have stored locally
    console.log('ALL CANVAS')

  } else {
    // Store this one particular canvas in the cloud
    console.log('SAVE THIS CANVAS',  targetCanvas)

    // Save the canvas to the storedCanvases
    const canvasTemplate = canavaStore.saveTemplateCanvas(targetCanvas);

    // Push the client to the saved canvas route
    router.push({name: 'canavaTemplate', params: {canvasTemplate: canvasTemplate}})
  }

};
</script>

<style lang="scss"></style>
