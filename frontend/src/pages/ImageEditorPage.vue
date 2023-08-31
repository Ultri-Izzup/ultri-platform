<template>
  <q-page class="justify-center">
    <div
      class="text-h4 row full-width justify-center text-center text-bold text-primary"
    >
      Image Editor
    </div>
    <iframe style="width:100%; height:1000px;" id="miniPaint" src="https://viliusle.github.io/miniPaint/" allow="camera"></iframe>
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
