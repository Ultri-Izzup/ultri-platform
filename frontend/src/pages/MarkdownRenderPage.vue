<template>
  <q-page class="row items-center justify-evenly">
    <div  :style="smallScreen ? 'width: 100%' : 'width: 80%'">
    <MdPreview v-model="md" language="en-US" :htmlPreview="true" @onSave="(event) => downloadData(event)" />
    </div>
  </q-page>
</template>

<script setup>
import {storeToRefs } from "pinia";
import {computed } from "vue";

import { useEditorStore } from "../stores/editor";
import { Screen } from "quasar";

import { MdPreview } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';

const editorStore = useEditorStore();

const { md } =storeToRefs(editorStore);

const layout = computed(() =>
  Screen.lt.sm ? "dense" : Screen.lt.md ? "comfortable" : "loose"
);

const smallScreen = computed(() => (Screen.lt.md ? true : false));


</script>

