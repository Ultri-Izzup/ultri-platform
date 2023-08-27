<template>
  <div>
    <div class="row full-width">
      <div :class="Screen.gt.md ? ' col-6 ' : ' col-12 '">
        <div class="row q-ml-xl q-pb-sm">
          <div class="col-3">
            <q-slider v-model="vh" :min="50" :max="200" :step="1"></q-slider>
          </div>
          <div class="col-1 justify-left q-pl-md q-pt-xs">Stretch</div>
          <div class="col-2 justify-right q-pl-xl">
            <q-btn
              @click="takeSnapshot()"
              color="primary"
              dense
              flat
              icon="mdi-camera"
              class="q-pt-none"
              label="Snapshot"
              ><q-tooltip>Download Image</q-tooltip></q-btn
            >
          </div>
        </div>
      </div>
      <div :class="Screen.gt.md ? ' col-6 ' : ' col-12 '">
        <div class="row q-ml-md q-pb-sm">
          <div class="col text-center">
            <q-toggle
              v-model="showInstructions"
              color="primary"
              label="Instructions"
              size="xs"
            ></q-toggle>
          </div>
          <div class="col text-center">
            <q-toggle
              v-model="showItems"
              color="primary"
              size="xs"
              label="Items"
            ></q-toggle>
          </div>
          <div class="col text-center">
            <q-toggle
              v-model="showDetail"
              color="primary"
              size="xs"
              label="Item Details"
            ></q-toggle>
          </div>
        </div>
      </div>
    </div>

    <q-separator />
    <div id="canvas-image-wrapper">
      <div class="row q-pa-md">
        <span class="text-h3">{{ value.name }}</span>
        <q-space></q-space>
      </div>
      <div class="q-ma-sm container-wrapper">
        <div v-if="value.sections.length > 0" class="container">
          <q-card
            class="container-card"
            :class="section.sectionKey"
            v-for="section in value.sections"
            :key="section.sectionKey"
            :style="
              'background-color: ' +
              section.backgroundColor +
              '; color: ' +
              section.textColor
            "
          >
            <q-card-section
              :class="colorStore.darkMode ? 'dark-top-q-card' : 'top-q-card'"
              :style="'background-color: ' + section.backgroundColor"
            >
              <p class="text-bold">
                <q-avatar v-if="section.sequence" size="24px" color="grey-4"
                  ><span class="text-grey-8">{{
                    section.sequence
                  }}</span></q-avatar
                >
                {{ section.title }}
                <sup>
                  <q-icon name="mdi-help-circle" size="13px" color="grey-6" />
                  <q-tooltip>
                    <span v-html="section.instructions" />
                  </q-tooltip>
                </sup>
              </p>
              <q-space />
              <q-icon
                name="mdi-magnify"
                size="20px"
                clickable
                v-ripple
                @click="magnifySection(section.sectionKey)"
                class="cursor-pointer"
              ></q-icon>
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
              v-if="
                showInstructions && (!section.items || section.items.length < 1)
              "
              v-ripple
              clickable
              @click="triggerNew(section.sectionKey)"
              class="q-pa-md text-italic cursor-pointer q-hoverable"
              ><div v-html="section.instructions" />
            </q-card-section>
            <q-card-section v-if="section.items && showItems" class="q-pa-none">
              <q-list separator>
                <q-item
                  v-for="item in section.items"
                  :key="item.uid"
                  clickable
                  v-ripple
                  @click="editItem(section.sectionKey, item.uid)"
                >
                  <q-item-section>
                    <q-item-label class="text-bold">
                      {{ item.label }}
                    </q-item-label>
                    <span v-if="showDetail" v-html="item.details"></span>
                  </q-item-section>
                </q-item>
              </q-list>
            </q-card-section>
          </q-card>
          <CanavaEditorSectionItemDialog
            v-model="showItemDialog"
            :section="currentSectionData"
            :item="toValue(currentItem)"
            @save="(event) => saveItem(event)"
            @delete="(event) => deleteItem(event)"
          />
          <CanavaMagnifySectionDialog
            v-model="showMagnifyDialog"
            :section="currentSectionData"
            @save="(event) => saveItem(event)"
            @delete="(event) => deleteItem(event)"
          />
        </div>
        <div v-else class="q-ma-sm">
          <div class="text-h6">Select a Canvas Template</div>
          <q-select
            v-model="selectedCanvas"
            label="Canvas Template"
            :options="canvasOpts"
            @update:model-value="emit('canvasSelected', selectedCanvas.value)"
          />
        </div>
      </div>
      <div class="row full-width text-center q-pa-sm">
        <div class="col-12 q-pa-lg" v-html="value.attribution"></div>
      </div>
    </div>
    <a id="downloadAnchorElem" style="display: none"></a>
  </div>
</template>

<script setup>
import { ref, computed, watch, unref, toValue, onMounted } from "vue";
import { Screen } from "quasar";

//import { nanoid } from "nanoid";
import { v4 as uuidv4 } from "uuid";

import * as htmlToImage from "html-to-image";
import { toPng, toJpeg, toBlob, toPixelData, toSvg } from "html-to-image";

import CanavaMagnifySectionDialog from "../canava/dialog/CanavaMagnifySectionDialog.vue";
import CanavaEditorSectionItemDialog from "../canava/dialog/CanavaEditorSectionItemDialog.vue";

import { useColorStore } from "../../stores/color";
// Instantiate our stores early so they are available
const colorStore = useColorStore();

const props = defineProps(["modelValue", "canvasOpts"]);
const emit = defineEmits(["update:modelValue", "canvasSelected"]);

const selectedCanvas = ref(null);

const takeSnapshot = () => {
  var canvasImageNode = document.getElementById("canvas-image-wrapper");

  htmlToImage
    .toPng(canvasImageNode, {
      style: {
        overflow: "hidden",
        "overflow-y": "hidden",
        "overflow-x": "hidden",
        "::-webkit-scrollbar": "none",
        "-ms-overflow-style": "none",
        "scrollbar-width": "none",
      },
      backgroundColor: "#FFFFFF",
    })
    .then(function (dataUrl) {
      var dlAnchorElem = document.getElementById("downloadAnchorElem");
      dlAnchorElem.setAttribute("href", dataUrl);
      dlAnchorElem.setAttribute("download", "canvas-image.png");
      dlAnchorElem.click();
    })
    .catch(function (error) {
      console.error("oops, something went wrong!", error);
    });
};

const currentSectionKey = ref(null);
const currentSectionData = ref({ title: "", instructions: "" });
const currentItem = ref({ uid: "", label: "", details: "" });
const showItemDialog = ref(false);
const showMagnifyDialog = ref(false);
const editorHelp = ref(false);
const add = ref(true);
const showDetail = ref(true);
const showInstructions = ref(true);
const showItems = ref(true);
const vh = ref(80);

watch(vh, (oldVal, newVal) => {
  console.log(vh.value);
  const element = document.querySelector(".container");
  element.style.height = vh.value + "vh";
});

const reset = () => {
  currentSectionKey.value = null;
  currentSectionData.value = { title: "", instructions: "" };
  currentItem.value = { uid: "", label: "", details: "" };
  editorHelp.value = false;
  showItemDialog.value = false;
  showMagnifyDialog.value = false;
  add.value = false;
};

const resetCurrentItem = () => {
  currentItem.value = { uid: "", label: "", details: "" };
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
  value,
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

      if(s.sectionKey === currentSectionKey.value) {
        currentSectionData.value = s
      }
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
  currentSectionData.value = filteredResult;
  resetCurrentItem();
  showItemDialog.value = true;
};

const toggleEditorHelp = () => {
  editorHelp.value = !editorHelp.value;
};

const editItem = (sectionKey, itemUid) => {
  currentSectionKey.value = sectionKey;
  const filteredResult = value.value.sections.find(
    (e) => e.sectionKey == sectionKey
  );
  currentSectionData.value = filteredResult;

  const itemData = filteredResult.items.find((e) => e.uid == itemUid);
  currentItem.value = itemData;

  showItemDialog.value = true;
};

const saveItem = (event) => {
  console.log(event.sectionKey, event.item);

  // Get current section data from the root data
  const ix = value.value.sections.findIndex(
    (element) => element.sectionKey == event.sectionKey
  );

  const currentData = value.value.sections[ix];

  if (!currentData.items) {
    currentData.items = [];
  }

  if (event.item.uid) {
    // Update, find the item index
    const itemIx = currentData.items.findIndex(
      (element) => element.uid == event.item.uid
    );

    // Save the new data to the same index
    currentData.items[itemIx] = event.item;
  } else {
    // Add, uid and push to array
    event.item.uid = uuidv4();
    currentData.items.push(event.item);
  }
};

const magnifySection = (sectionKey) => {
  console.log(sectionKey);
  currentSectionKey.value = sectionKey;
  const filteredResult = value.value.sections.find(
    (e) => e.sectionKey == sectionKey
  );
  currentSectionData.value = filteredResult;

  showMagnifyDialog.value = true;

  //const currentSectionKey = ref(null);
  //const currentSectionData = ref({ title: "", instructions: "" });
};

const deleteItem = () => {
  // Get the current Section data
  const sectionDataIx = value.value.sections.findIndex(
    (element) => element.sectionKey == currentSectionKey.value
  );
  const sectionData = value.value.sections[sectionDataIx];

  console.log(sectionData);
  // Find the index of the item to delete
  const ix = sectionData.items.findIndex(
    (element) => element.uid == currentItem.value.uid
  );

  // // Remove the one item
  sectionData.items.splice(ix, 1);

  // // Update the main data
  value.value.sections[sectionDataIx] = sectionData;
};
</script>

<style lang="scss" scoped>
.container {
  display: grid;
  height: 60vh;
}
.container-wrapper {
  border-style: solid;
  border-width: 1px;
  border-color: $grey-4;
  border-radius: 5px;
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
