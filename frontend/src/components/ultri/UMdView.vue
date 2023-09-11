<template>
  <div>
    <MdPreview v-model="val" language="en-US" />
  </div>
</template>

<script setup lang="js">
import { toRef } from 'vue';

import { MdPreview } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';

const props = defineProps({
  modelValue: {
    type: String,
  }
})

console.log(props)

const val = toRef(props.modelValue)
</script>
