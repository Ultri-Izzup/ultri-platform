<template>
  <div>Canvas Editor Component</div>
  <!-- {{modelValue}} -->
</template>

<script setup>
import { computed } from 'vue'

defineProps(['modelValue'])
defineEmits(['update:modelValue'])

const value = computed({
  get() {
    return props.modelValue
  },
  set(value) {
    emit('update:modelValue', value)
  }
})

</script>
