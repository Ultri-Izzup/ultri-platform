<template>
  <div>
    <div class="row">
      <q-btn label="Reset Features" @click="clearStores"></q-btn>
    </div>
    Features:
    <q-toggle v-for="(value, propertyName) in ufs.booleans"
      v-model="ufs.$state[value]" :key="propertyName"
      color="green"
      label="auth"
    ></q-toggle>

  </div>
</template>

<script setup>
import VueJsonPretty from "vue-json-pretty";
import "vue-json-pretty/lib/styles.css";

import { useFeatureStore } from "../stores/feature"
const ufs = useFeatureStore();

const clearStores = () => {
  console.log("Clearing stores")
  ufs.$reset();
};
</script>
