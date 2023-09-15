<template>
  <q-page class="justify-center">
    <div
      class="text-h4 row full-width justify-center text-center text-bold text-primary"
    >
      <span class="q-px-md">Markdown Editor</span> <q-space />
      <q-btn
        v-if="$q.platform.is.desktop && $q.platform.is.chrome"
        label="Open"
        class="q-mx-sm"
        @click="triggerFilePicker()"
      ></q-btn>
      <!-- <q-btn icon="mdi-eye" label="View" to="/editors/markdown/viewer" class="q-mx-md"></q-btn> -->
    </div>
    <div class="row flex fit q-pa-sm">
      <MdEditor
        v-model="editorStore.md"
        language="en-US"
        @onSave="(event) => saveToFile(event)"
      />
      <!-- <MdEditor v-model="editorStore.md" language="en-US" @onSave="(event) => downloadData(event)" /> -->
    </div>
    <a id="downloadAnchorElem" style="display: none"></a>
  </q-page>
</template>

<script setup>
import { ref, computed, toValue } from "vue";
import { useQuasar, Screen } from "quasar";

import { MdEditor, config } from "md-editor-v3";
import "md-editor-v3/lib/style.css";

import MarkdownItAbbr from "markdown-it-abbr";
import MarkdownItAnchor from "markdown-it-anchor";
import MarkdownItFootnote from "markdown-it-footnote";
import MarkdownItHighlightjs from "markdown-it-highlightjs";
import MarkdownItSub from "markdown-it-sub";
import MarkdownItSup from "markdown-it-sup";
import MarkdownItTasklists from "markdown-it-task-lists";
import MarkdownItTOC from "markdown-it-toc-done-right";
import MarkdownItAttrs from "markdown-it-attrs";
import MarkdownItStyle from "markdown-it-style";

import { useEditorStore } from "../stores/editor";

config({
  markdownItConfig(mdit) {
    mdit.use(MarkdownItAbbr);
    mdit.use(MarkdownItAnchor);
    mdit.use(MarkdownItFootnote);
    mdit.use(MarkdownItHighlightjs);
    mdit.use(MarkdownItSub);
    mdit.use(MarkdownItSup);
    mdit.use(MarkdownItTasklists);
    mdit.use(MarkdownItTOC);
    mdit.use(MarkdownItAttrs);
    mdit.use(MarkdownItStyle);
  },
});

const editorStore = useEditorStore();

const $q = useQuasar();

const fh = ref();

const downloadData = (data) => {
  console.log(data);
  var dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(`${data}`);
  var dlAnchorElem = document.getElementById("downloadAnchorElem");
  dlAnchorElem.setAttribute("href", dataStr);
  dlAnchorElem.setAttribute("download", "document.md");
  dlAnchorElem.click();
};

const triggerFilePicker = async () => {
  console.log("test");

  const [fileHandle] = await window.showOpenFilePicker();
  console.log(fileHandle);
  fh.value = fileHandle;
  const file = await fileHandle.getFile();
  const contents = await file.text();
  console.log(contents);
  editorStore.md = contents;
};

const saveToFile = async (contents) => {
  const writable = await fh.value.createWritable();
  await writable.write(contents);
  return await writable.close();
};
</script>
<style lang="scss" scoped>
body {
  scroll-behavior: smooth;
}

ol {
  counter-reset: list-item;
}
li {
  display: block;
  counter-increment: list-item;
}
li:before {
  content: counters(list-item, ".") " ";
}
</style>
