<template>
  <q-page class="justify-center">
    <div class="text-h4 row full-width justify-center text-center text-bold text-primary">
      <span class="q-px-md">JSON Editor</span>  <q-space />
      <q-btn v-if="$q.platform.is.desktop && $q.platform.is.chrome" label="Open" class="q-mx-sm" @click="triggerFilePicker()"></q-btn>
      <!-- <q-btn icon="mdi-eye" label="View" to="/editors/markdown/viewer" class="q-mx-md"></q-btn> -->
    </div>
    <div class="row flex fit q-pa-sm">
      <vue-jsoneditor
        height="400"
        mode="tree"
        v-model:json="editorStore.json"
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

const fh = ref();

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

const triggerFilePicker = async () => {
  console.log('test')

  const [fileHandle] = await window.showOpenFilePicker();
  console.log(fileHandle)
  fh.value = fileHandle;
  const file = await fileHandle.getFile();
  const contents = await file.text();
  console.log(contents)
  editorStore.json = contents;
}

const saveToFile = async (contents) => {
  const writable = await fh.value.createWritable();
  await writable.write(contents);
  return await writable.close();
}


</script>
<style></style>
