<template>
  <div class="row full-width">
    <div>{{ value.name }}</div>
    <q-list class="row full-width">
      <q-item v-for="section in value.sections" :key="section.sectionkey" class="row full-width">
        <q-item-section class="row full-width">
          <q-item-label class="text-h6">{{ section.title }}</q-item-label>
          <q-input label="Title" v-model="section.title"></q-input>
          <q-input
            label="Instructions"
            v-model="section.instructions"
            auto-grow
          ></q-input>
          <q-input label="Key" v-model="section.sectionKey"></q-input>
          <q-input label="Columns" v-model="section.gridColumn"></q-input>
          <q-input label="Rows" v-model="section.gridRow"></q-input>
        </q-item-section>
      </q-item>
    </q-list>
  </div>
</template>

<script setup>
import { computed } from "vue";

const props = defineProps(["modelValue"]);
const emit = defineEmits(["update:modelValue"]);

const value = computed({
  get() {
    return props.modelValue;
  },
  set(value) {
    emit("update:modelValue", value);
  },
});
</script>
