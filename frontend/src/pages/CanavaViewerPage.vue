<template>
  <div>
    <q-btn :to="canvasConfigRoute" dense round flat icon="mdi-cog-outline" size="sm"><q-tooltip>Configure</q-tooltip></q-btn>
    <CanavaEditor v-model="canavaStore.canvasData" :canvasOpts="canavaStore.canvasOpts" @canvasSelected="(event) => canavaStore.loadCanvasTemplate(event) "></CanavaEditor>
  </div>
</template>

<script setup>
import {ref, watch, computed } from "vue"
import { useRoute } from "vue-router"
// Import stores
import { useCanavaStore } from "../stores/canava";

import { v4 as uuidv4 } from "uuid";

// Import the individual canvas SFC module
import CanavaEditor from "../components/canava/CanavaEditor.vue";

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

const canavaStore = useCanavaStore();

const route = useRoute();

const canvasConfigRoute = computed(() => {
  let configRoute = '';
  switch(route.name) {
    case 'canavaDesignerViewer':
    configRoute = "/canava/designer"
  }
  return configRoute;
})

watch(
  () => route.params.canvasTemplate,
  (newTemplate) => {
    if(newTemplate) {
      canavaStore.loadCanvasTemplate(newTemplate)
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

const loadCanvasTemplate = (event) => {
  console.log(event);

  const templateData = canvasMap[event];

  templateData.sections.forEach(function(item, index) {
    if(!item.uid) {
      item.uid = uuidv4();
    }
    console.log(item, index);
  });

  canavaStore.canvasData = templateData;
};

</script>

<style lang="scss">
</style>
