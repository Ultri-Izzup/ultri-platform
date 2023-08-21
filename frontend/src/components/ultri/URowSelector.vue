<template>
  <div>
    TEST2
    {{ value }}
    {{startCol}}
    {{endCol}}
    <q-range
      v-model="minMax"
      :min="1"
      :max="12"
      :step="1"
      label-always
      color="primary"
    ></q-range>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps(['modelValue'])
const emit = defineEmits(['update:modelValue'])

const numCols = 12;

console.log(props)

const value = computed({
  get() {
    return props.modelValue
  },
  set(value) {
    emit('update:modelValue', value)
  }
})

const startCol = computed(() => {
  return value.value.split('/')[0]
})

const endCol = computed(() => {
  return value.value.split('/')[1] - 1
})

const minMax = computed({
  get() {
    return { min: startCol.value, max: endCol.value }
  },
  set(value) {
    const valStr = value.min + '/' + (value.max + 1);
    emit('update:modelValue', valStr)
  }

})





</script>

<style lang="scss">
</style>
