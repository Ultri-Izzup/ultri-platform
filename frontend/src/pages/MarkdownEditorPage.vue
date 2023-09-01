<template>
  <q-page class="justify-center">
    <div class="text-h4 row full-width justify-center text-center text-bold text-primary">
      Markdown Editor
    </div>
    <div class="row flex fit q-pa-sm">
    <MdEditor v-model="editorStore.md" language="en-US"/>
    </div>

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

</script>
<style></style>
