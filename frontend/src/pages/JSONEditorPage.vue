<template>
  <q-page class="justify-center">
    <div
      class="text-h4 row full-width justify-center text-center text-bold text-primary"
    >
      JSON Editor
    </div>
    <div class="row flex fit q-pa-sm">
      <vue-jsoneditor
        height="400"
        mode="tree"
        v-model:json="jsonData"
      />
    </div>
  </q-page>
</template>

<script setup>
import { ref, computed, toValue } from "vue";
import { Screen } from "quasar";

import VueJsoneditor from "vue3-ts-jsoneditor";

import { useEditorStore } from "../stores/editor";

const editorStore = useEditorStore();

const jsonData = ref(null);
</script>
<style></style>
