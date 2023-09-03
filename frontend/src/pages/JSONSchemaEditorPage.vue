s<template>
  <q-page class="justify-center">
    <div
      class="text-h4 row full-width justify-center text-center text-bold text-primary"
    >
      JSON Schema Editor
    </div>
    <div class="row flex fit q-pa-sm">
      <json-schema-editor :value="{root: { type: 'object' } }" lang="en_US"/>

    </div>
  </q-page>
</template>

<script setup>
import { ref, computed, toValue } from "vue";
import { Screen } from "quasar";

import VueJsoneditor from "vue3-ts-jsoneditor";

//import JsonSchemaEditor from 'json-schema-editor-vue3'
//import 'json-schema-editor-vue3/lib/json-schema-editor-vue.css'

import { useEditorStore } from "../stores/editor";

const editorStore = useEditorStore();

</script>
<style></style>
