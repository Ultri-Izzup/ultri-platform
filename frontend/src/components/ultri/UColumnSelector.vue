<template>
  <div class="q-pa-none q-ma-none">
    <div class="q-py-sm">
      <span class="text-caption text-weight-light">Columns</span>
    </div>
    <div class="q-pt-lg q-px-md">
      <q-range
        v-model="minMax"
        :min="1"
        :max="12"
        :step="1"
        marker-labels
        label-always
        color="primary"
        snap
        drag-range
      ></q-range>
    </div>
  </div>
</template>

<script setup>
import { computed } from "vue";

const props = defineProps(["modelValue"]);
const emit = defineEmits(["update:modelValue"]);

const numCols = 12;

const value = computed({
  get() {
    return props.modelValue;
  },
  set(value) {
    emit("update:modelValue", value);
  },
});

if(typeof value.value === "undefined"){
  value.value = "1/4"
}

const startCol = computed(() => {
  return value.value ? value.value.split("/")[0] : 1 ;
});

const endCol = computed(() => {
  return value.value ? value.value.split("/")[1] - 1 : 4;
});

const minMax = computed({
  get() {
    return { min: startCol.value, max: endCol.value };
  },
  set(value) {
    const valStr = value.min + "/" + (value.max + 1);
    emit("update:modelValue", valStr);
  },
});
</script>

<style lang="scss">
</style>
