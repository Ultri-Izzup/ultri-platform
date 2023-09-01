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
   <!-- <pre>TEMPLATE {{canvasTemplate}} TEMPLATECANVASES{{canavaStore.storedCanvases}} </pre> -->
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
import { useRoute } from "vue-router";
// Import stores
import { useCanavaStore } from "../stores/canava";

// Import the individual canvas SFC module
import CanavaViewer from "../components/canava/CanavaViewer.vue";

const canavaStore = useCanavaStore();

const canvasTemplate = ref(null);

const route = useRoute();

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
  } else if (targetCanvas === 'ALL') {
    canvases = {...canavaStore.storedCanvases, ...{ custom: {
      name: canavaStore.canvasData.name,
      completedOn: canavaStore.canvasData.completedOn,
      completedBy: canavaStore.canvasData.completedBy,
      attribution: canavaStore.canvasData.attribution,
      version: canavaStore.canvasData.version,
      sections: canavaStore.canvasData.sections,
      sequenced: canavaStore.canvasData.sequenced ? true : false,
      canavaVers: "1.0.0",
    }}
  }
  } else {
    canvases[targetCanvas] = canavaStore.storedCanvases[targetCanvas];
  }

  var dataStr =
    "data:text/json;charset=utf-8," +
    encodeURIComponent(JSON.stringify({canvases: canvases}, 0, 2));
  var dlAnchorElem = document.getElementById("downloadAnchorElem");
  dlAnchorElem.setAttribute("href", dataStr);
  dlAnchorElem.setAttribute("download", "canvas.json");
  dlAnchorElem.click();
};
</script>

<style lang="scss"></style>
