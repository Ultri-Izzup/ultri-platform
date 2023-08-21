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
          <q-avatar v-if="section.sequence" size="24px" color="grey-4"
            ><span class="text-grey-8">{{ section.sequence }}</span></q-avatar
          >
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
          @click="triggerNew(section.sectionKey)"
          class="cursor-pointer"
        ></q-icon>
      </q-card-section>
      <q-card-section>
        <q-list separator>
          <q-card-section
            v-ripple
            clickable
            @click="triggerNew()"
            class="q-pa-sm text-italic cursor-pointer q-hoverable"
          >
            {{ section.instructions }}
          </q-card-section>
        </q-list>
      </q-card-section>
    </q-card>
      <q-dialog v-model="showDialog">
        <q-card>
          <q-bar class="bg-primary">
            New Item
            <q-space></q-space>
            <q-btn
              dense
              flat
              icon="mdi-close"
              v-close-popup
              @click="reset()"
            >
              <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
            </q-btn>
          </q-bar>
          <q-card-section>



          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn label="Save" color="primary" @click="saveNew()"></q-btn>
          </q-card-actions>
        </q-card>
      </q-dialog>
  </div>
</template>

<script setup>
import { ref, computed, watch } from "vue";

import { nanoid } from "nanoid";

import { useColorStore } from "../../stores/color";
// Instantiate our stores early so they are available
const colorStore = useColorStore();

const props = defineProps(["modelValue"]);
const emit = defineEmits(["update:modelValue"]);

const currentSection = ref(null);
const showDialog = ref(false);
const add = ref(true);

const reset = () => {
  showDialog.value = false;
  add.value = false;
}

const value = computed({
  get() {
    return props.modelValue;
  },
  set(value) {
    emit("update:modelValue", value);
  },
});

let sheet = document.createElement("style");
document.body.appendChild(sheet);

watch(value.value.sections, (newVal, oldVal) => {
  let dynamicStyles = "@media screen and (min-width: 864px) { \n";

  value.value.sections.forEach((s) => {
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

  dynamicStyles = dynamicStyles + " } \n";

  sheet.innerHTML = dynamicStyles;
},{ immediate: true });

const triggerNew = (sectionName) => {
  currentSection.value = sectionName;
  showDialog.value = true;
};
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
