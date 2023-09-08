<template>
  <q-page class="justify-center">
    <div class="text-h4 row full-width justify-center text-center text-bold text-primary">
      <span class="q-px-md">Markdown Editor</span> <q-space /> <q-btn icon="mdi-eye" label="Web Preview" to="/editors/markdown/viewer"></q-btn>
    </div>
    <div class="row flex fit q-pa-sm">
    <MdEditor v-model="editorStore.md" language="en-US" @onSave="(event) => downloadData(event)" />
    </div>
    <a id="downloadAnchorElem" style="display: none"></a>
  </q-page>
</template>

<script setup>
import { ref, computed, toValue } from "vue";
import { Screen } from "quasar";

import { MdEditor } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';

import { useEditorStore } from "../stores/editor";

const editorStore = useEditorStore();

const mdData = ref('');

const downloadData = (data) => {
  console.log(data)
  var dataStr =
    "data:text/json;charset=utf-8," +
    encodeURIComponent(`${data}`);
  var dlAnchorElem = document.getElementById("downloadAnchorElem");
  dlAnchorElem.setAttribute("href", dataStr);
  dlAnchorElem.setAttribute("download", "document.md");
  dlAnchorElem.click();
};

</script>
<style></style>
