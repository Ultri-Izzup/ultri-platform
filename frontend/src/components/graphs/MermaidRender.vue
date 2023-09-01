<template>
  <VueMermaidRender content="" />
</template>

<script setup>

import VueMermaidRender from "vue-mermaid-render"

const props = defineProps(["modelValue"]);
const emit = defineEmits(["update:modelValue"]);


</script>



<style scoped lang="scss">
</style>
