<template>
  <div>
    <div class="row full-width q-px-lg q-pb-md">
      <div class="col-2">
        <span class="text-h6 q-pr-md">Canvas Height:</span>

      <q-slider v-model="vh" :min="50" :max="200" :step="1"></q-slider>
    </div>
    <div class="col-2">
      <span class="text-h6 q-pl-lg q-pr-md">Show Detail:</span>

      <q-toggle v-model="showDetail" color="primary"></q-toggle>
      </div>
      <q-space></q-space>
    </div>

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
        <q-card-section
          v-if="!section.items"
          v-ripple
          clickable
          @click="triggerNew(section.sectionKey)"
          class="q-pa-md text-italic cursor-pointer q-hoverable"
          >{{ section.instructions }}
        </q-card-section>
        <q-card-section v-else class="q-pa-none">
          <q-list separator>
            <q-item v-for="item in section.items" :key="item.uid">
              <q-item-section>
                <q-item-label class="text-bold">
                  {{ item.label }}
                </q-item-label>
                <span v-if="showDetail" class="text-caption">{{
                  item.details
                }}</span>
              </q-item-section>
            </q-item>
          </q-list>
        </q-card-section>
      </q-card>
      <q-dialog v-model="showDialog">
        <q-card>
          <q-bar class="bg-primary">
            Add to {{ currentSectionData.title }}
            <sup class="q-pl-xs clickable v-ripple" @click="toggleEditorHelp()">
              ?
            </sup>
            <q-space></q-space>
            <q-btn dense flat icon="mdi-close" v-close-popup @click="reset()">
              <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
            </q-btn>
          </q-bar>
          <q-card-section>
            <div
              v-if="!editorHelp"
              class="row full-width text-italic text-body1 q-pa-sm"
            >
              {{ currentSectionData.instructions }}
            </div>

            <q-input label="Label" v-model="currentItem.label"></q-input>
            <q-input label="Details" v-model="currentItem.details"></q-input>
          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn label="Save" color="primary" @click="save()"></q-btn>
          </q-card-actions>
        </q-card>
      </q-dialog>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, unref } from "vue";

import { nanoid } from "nanoid";

import { useColorStore } from "../../stores/color";
// Instantiate our stores early so they are available
const colorStore = useColorStore();

const props = defineProps(["modelValue"]);
const emit = defineEmits(["update:modelValue"]);

const currentSectionKey = ref(null);
const currentSectionData = ref({ title: "", instructions: "" });
const currentItem = ref({ label: "", details: "" });
const showDialog = ref(false);
const editorHelp = ref(false);
const add = ref(true);
const showDetail = ref(true);
const vh = ref(80);



watch((vh), (oldVal, newVal) => {
  console.log(vh.value);
  const element = document.querySelector(".container");
  element.style.height = vh.value + 'vh';
})

const reset = () => {
  currentSectionKey.value = null;
  currentSectionData.value = { title: "", instructions: "" };
  currentItem.value = { label: "", details: "" };
  editorHelp.value = false;
  showDialog.value = false;
  add.value = false;
};

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

watch(
  value.value.sections,
  (newVal, oldVal) => {
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
  },
  { immediate: true }
);

const triggerNew = (sectionKey) => {
  currentSectionKey.value = sectionKey;
  const filteredResult = value.value.sections.find(
    (e) => e.sectionKey == sectionKey
  );

  console.log(filteredResult);
  currentSectionData.value = filteredResult;
  showDialog.value = true;
};

const toggleEditorHelp = () => {
  editorHelp.value = !editorHelp.value;
};

const save = () => {
  // Set ID for new records
  if (!currentItem.value.uid) {
    currentItem.value.uid = nanoid();
  }

  console.log(currentItem.value);

  // Create section items array if missing
  if (!currentSectionData.value.items) {
    currentSectionData.value.items = [];
  }

  currentSectionData.value.items.push(unref(currentItem.value));

  console.log(currentSectionData.value);

  reset();
  // Save current section item
};
</script>

<style lang="scss" scoped>
.container {
  display: grid;
  height: 60vh;
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
