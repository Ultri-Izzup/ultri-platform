<template>
  <q-page class="justify-center">
    <div class="row flex fit q-pa-sm">
      <u-md-view v-model="editorStore.md" />
    </div>
    <a id="downloadAnchorElem" style="display: none"></a>
  </q-page>
</template>

<script setup>
import { ref, computed, toValue } from "vue";
import { Screen } from "quasar";

import UMdView from "../components/ultri/UMdView.vue"

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
<style lang="scss">
h1.markdown {
  color: green;
}
.markdown {
  color: blue;
}
</style>
