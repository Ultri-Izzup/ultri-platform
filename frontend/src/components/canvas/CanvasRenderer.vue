<template>
  <div class="container">
    <q-card
      class="container-card"
      :class="section.sectionKey"
      v-for="section in value.sections"
      :key="section.sectionKey"
    >
      <q-card-section
        :class="colorStore.darkMode ? 'dark-top-q-card' : 'top-q-card'"
      >
        <p class="text-bold">
          {{ section.title }}
          <sup>
            ?
            <q-tooltip>
              {{ section.instructions }}
            </q-tooltip>
          </sup>
        </p>
        <q-icon
          name="mdi-plus-circle-outline"
          size="20px"
          clickable
          v-ripple
          @click="dialogVisible = true"
          class="cursor-pointer"
        ></q-icon> </q-card-section
    >
    <q-card-section>
      <q-list separator>
      <q-card-section v-ripple clickable @click="dialogVisible = true"
        class="q-pa-lg text-italic text-italic cursor-pointer q-hoverable">
        {{ section.instructions }}
      </q-card-section>


    </q-list>
    </q-card-section>
    </q-card>
  </div>
</template>

<script setup>
import CanavaSection from "./CanavaSection.vue";

import { computed, unref } from "vue";

import { useColorStore } from "../../stores/color";
// Instantiate our stores early so they are available
const colorStore = useColorStore();

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

let sheet = document.createElement("style");

let dynamicStyles = "";

value.value.sections.forEach((s) => {
  console.log(s);
  const sectionCSS =
    "." +
    s.sectionKey +
    " { grid-column: " +
    s.gridColumn +
    "; grid-row: " +
    s.gridRow +
    "; } \n";
  dynamicStyles = dynamicStyles + sectionCSS;
});

console.log(dynamicStyles);

sheet.innerHTML = dynamicStyles;

console.log(sheet);

document.body.appendChild(sheet);
</script>

<style lang="scss" scoped>
.container {
  display: grid;
}
::-webkit-scrollbar {
  display: none;
}
.dark-top-q-card {
  position: sticky;
  top: -10px;
  background-color: $dark;
  color: white;
  z-index: 2;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0px;
  padding-bottom: 1px;
}
.top-q-card {
  position: sticky;
  top: -10px;
  background-color: white;
  z-index: 2;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0px;
  padding-bottom: 1px;
}
p {
  margin: 0;
  padding: 10px;
}

.container-card {
  word-break: break-word;
  overflow: scroll;
  padding: 10px;
  box-shadow: 1px 10px 10px rgba(128, 128, 128, 0.2);
  min-height: 100%;
  border-color: lightgray;
  border-width: 1px;
  border-style: solid;
}
.q-dialog .q-card {
  min-width: 350px;
}
.input {
  width: 100%;
  padding: 0 20px;
}
</style>
