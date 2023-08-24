<template>
  <div class="q-pa-none q-ma-none">
    <div class="q-py-sm">
      <span class="text-caption text-weight-light">Rows</span>
    </div>
    <div class="q-pl-lg">
      <q-range
        v-model="minMax"
        :min="1"
        :max="24"
        :step="1"
        :marker-labels="rowMarkerLabels"
        label-always
        color="primary"
        vertical
        snap
        drag-range=""
        switch-label-side
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
  return value.value ? value.value.split("/")[0] : 1;
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

const rowMarkerLabels = { 2: '2', 4: '4', 6: '6', 8: '8', 10: '10', 12: '12', 14: '14', 16: '16', 18: '18', 20: '20', 22: '22', 24: '24' };
</script>

<style lang="scss">
</style>
