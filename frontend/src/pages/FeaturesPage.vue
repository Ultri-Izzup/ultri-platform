<template>
  <q-page class="">
    <div class="text-h6">Features:</div>
    <q-toggle v-for="(value, propertyName) in ufs.booleans"
      v-model="ufs.$state[value]" :key="propertyName"
      color="green"
      :label="propertyName"
    ></q-toggle>

    <div class="text-h6">Enable Canvas:</div>
    {{selectedCanvas}}
    <q-select v-model="selectedCanvas" :options="ufs.disabledCanvas" label="Disabled Canvas"></q-select>
    <q-btn label="Enable Canvas" @click="enableCanvas()"></q-btn>

  </q-page>
</template>

<script setup>
import { ref } from "vue";
import VueJsonPretty from "vue-json-pretty";
import "vue-json-pretty/lib/styles.css";

import { useFeatureStore } from "../stores/feature"
import { conditionalExpression } from "@babel/types";
const ufs = useFeatureStore();

// ref to hold the slected canvas for temp enabling
const selectedCanvas = ref(null);

// Set canvas enabled in this session
const enableCanvas = () => {
  // index of canvas name in array
  console.log(ufs.disabledCanvas);
  const stillDisabled = ufs.disabledCanvas.filter((canvas) =>  canvas != selectedCanvas.value)
  console.log('REAMISN', stillDisabled)
  ufs.disabledCanvas = stillDisabled;
  console.log(ufs.disabledCanvas);
}

const clearStores = () => {
  console.log("Clearing stores")
  ufs.$reset();
};
</script>
