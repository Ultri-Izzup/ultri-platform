<template>
  <q-page class="row items-center justify-evenly">

    <VueMermaidRender :content="content"></VueMermaidRender>
  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { useQuasar } from "quasar";

import { useEditorStore } from "../stores/editor";
import { Screen } from "quasar";

import VueMermaidRender from "vue-mermaid-render"

const content = ref(`
graph TD;
  A-->B;
  A-->C;
  B-->D;
  C-->D;
`)

const editorStore = useEditorStore();

</script>

