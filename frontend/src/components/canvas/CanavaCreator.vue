<template>
  <div>
    <div class="q-pa-md">
      <q-btn label="Add Section" @click="triggerNew()" color="primary" />
    </div>
    <div class="container">
      <q-card
        class="container-card"
        v-for="section in value.sections"
        :key="section.sectionKey"
        :class="section.sectionKey"
      >
        <q-card-section
          :class="colorStore.darkMode ? 'dark-top-q-card' : 'top-q-card'"
        >
          <p class="text-bold">
            <q-avatar v-if="section.sequence" size="24px" color="grey-4"
              ><span class="text-grey-7">{{ section.sequence }}</span></q-avatar
            >
            {{ section.title }}
          </p>
          <q-icon
            name="mdi-pencil-circle-outline"
            size="20px"
            clickable
            v-ripple
            @click="triggerEdit(section.sectionKey)"
            class="cursor-pointer"
          ></q-icon>
        </q-card-section>
      </q-card>
      <q-dialog v-model="showEditDialog">
        <q-card>
          <q-bar class="bg-primary">
            Edit Canvas Section
            <q-space></q-space>
            <q-btn
              dense
              flat
              icon="mdi-delete"
              v-close-popup
              @click="deleteSection(currentSectionData.sectionKey)"
            >
              <q-tooltip>{{ $t("nav.delete") }} </q-tooltip>
            </q-btn>
            <q-btn dense flat icon="mdi-close" v-close-popup @click="resetNew">
              <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
            </q-btn>
          </q-bar>
          <q-card-section>
            <q-input label="Title" v-model="currentSectionData.title" />
            <q-input
              autogrow
              label="Instructions"
              v-model="currentSectionData.instructions"
            />
            <q-input label="Key" v-model="currentSectionData.sectionKey" />
            <UColumnSelector v-model="currentSectionData.gridColumn" />
            <q-input label="Cols" v-model="currentSectionData.gridColumn" />
            <q-input label="Rows" v-model="currentSectionData.gridRow" />
            <q-input
              label="Sequence (opt)"
              v-model="currentSectionData.sequence"
            />
          </q-card-section>
        </q-card>
      </q-dialog>
      <q-dialog v-model="showNewDialog">
        <q-card>
          <q-bar class="bg-primary">
            New Canvas Section
            <q-space></q-space>
            <q-btn
              dense
              flat
              icon="mdi-close"
              v-close-popup
              @click="resetNew()"
            >
              <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
            </q-btn>
          </q-bar>
          <q-card-section>
            <q-input label="Title" v-model="newSectionData.title" />
            <q-input
              autogrow
              label="Instructions"
              v-model="newSectionData.instructions"
            />
            <q-input label="Key" v-model="newSectionData.sectionKey" />
            <q-input label="Cols" v-model="newSectionData.gridColumn" />
            <q-input label="Rows" v-model="newSectionData.gridRow" />
            <q-input label="Sequence (opt)" v-model="newSectionData.sequence" />
          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn label="Save" color="primary" @click="saveNew()"></q-btn>
          </q-card-actions>
        </q-card>
      </q-dialog>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from "vue";

import { useColorStore } from "../../stores/color";

import UColumnSelector from "../ultri/UColumnSelector.vue"

// Instantiate our stores early so they are available
const colorStore = useColorStore();

const props = defineProps(["modelValue"]);
const emit = defineEmits(["update:modelValue"]);

const showEditDialog = ref(false);
const showNewDialog = ref(false);

const currentSectionKey = ref(null);
const currentSectionData = ref(null);
const newSectionData = ref({});

const value = computed({
  get() {
    return props.modelValue;
  },
  set(value) {
    emit("update:modelValue", value);
  },
});

let sheet = document.createElement("style");

let dynamicStyles = "@media screen and (min-width: 864px) { \n";

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

dynamicStyles = dynamicStyles + " } \n";

console.log(dynamicStyles);

sheet.innerHTML = dynamicStyles;
document.body.appendChild(sheet);

watch(value.value.sections, (newVal, oldVal) => {
  let dynamicStyles = "@media screen and (min-width: 864px) { \n";

  value.value.sections.sort(
    (a, b) =>
      a.gridRow.localeCompare(b.gridRow) ||
      a.gridColumn.localeCompare(b.gridColumn)
  );

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

  dynamicStyles = dynamicStyles + " } \n";

  sheet.innerHTML = dynamicStyles;
});

const triggerEdit = (sectionKey) => {
  currentSectionKey.value = sectionKey;
  const filteredResult = value.value.sections.find(
    (e) => e.sectionKey == sectionKey
  );

  console.log(filteredResult);
  currentSectionData.value = filteredResult;
  showEditDialog.value = true;
};

const triggerNew = () => {
  showNewDialog.value = true;
};

const deleteSection = (sectionKey) => {
  currentSectionKey.value = sectionKey;
  value.value.sections.splice(
    value.value.sections.findIndex((item) => item.sectionKey === sectionKey),
    1
  );
};

const saveNew = () => {
  console.log(newSectionData.value);
  value.value.sections.push(newSectionData.value);
};

const resetNew = () => {
  newSectionData.value = {};
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
