<template>
  <q-page class="row items-center justify-evenly">
    <vue-mermaid-string :value="mermaidMd" />
  </q-page>
</template>

<script setup>
import {storeToRefs } from "pinia";
import {ref } from "vue";

import { useEditorStore } from "../stores/editor";

import VueMermaidString from 'vue-mermaid-string'

const editorStore = useEditorStore();

const { md } =storeToRefs(editorStore);

const mdLines = ref(md.value.split(/[\r\n]+/))

console.log(mdLines.value)

mdLines.value.shift()
mdLines.value.pop()
mdLines.value.pop()

const mermaidMd =
mdLines.value.join('\r\n')


</script>

