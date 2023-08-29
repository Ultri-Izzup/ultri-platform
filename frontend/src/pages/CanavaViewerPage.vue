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
    } else {
      canvasTemplate.value = null;
    }
  },
  { immediate: true }
);
</script>

<style lang="scss"></style>
