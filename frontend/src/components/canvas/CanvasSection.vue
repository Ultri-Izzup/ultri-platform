<template>
  <q-card class="container-card" :class="info.class">
    <q-card-section
      :class="colorStore.darkMode ? 'dark-top-q-card' : 'top-q-card'"
    >
      <p class="text-bold">
        {{ info.title }}
        <sup>
          ?
          <q-tooltip>
            {{ info.instructions }}
          </q-tooltip>
        </sup>
      </p>
      <q-icon
        name="mdi-plus-circle-outline"
        size="20px"
        @click="dialogVisible = true"
      ></q-icon>
    </q-card-section>
    <q-separator></q-separator>
    <q-list separator>
      <q-card-section
        class="q-pa-lg text-italic text-italic"
        v-show="
          canvas[canvasName][info.sectionKey].size === 0 ||
          (Object.keys(canvas[canvasName][info.sectionKey]).length === 0 &&
            canvas[canvasName][info.sectionKey].constructor === Object)
        "
        >{{ info.instructions }}</q-card-section
      >

      <q-item
        v-for="[k, item] in canvas[canvasName][info.sectionKey]"
        :key="k"
        clickable
        class="q-pa-lg items-center"
        @click="showEditItem(info.sectionKey, item.uid)"
      >
        {{ item.text }}
      </q-item>
    </q-list>

    <q-dialog v-model="dialogVisible">
      <q-card>
        <q-card-section>
          <!-- Dialog content goes here -->
          <p>Add {{ info.title }}</p>
        </q-card-section>
        <q-input v-model.trim="itemInput" class="input"></q-input>
        <q-banner
          class="bg-red text-white q-pa-sm q-mt-sm text-center"
          v-if="errorMessage"
          >Please add more characters</q-banner
        >
        <q-card-actions align="evenly">
          <!-- Dialog actions (buttons) go here -->
          <q-btn
            v-if="!add"
            label="Delete"
            color="secondary"
            @click="deleteItem(info.sectionKey, currentItem)"
          />
          <q-btn
            label="add"
            v-if="add"
            color="primary"
            @click="addItem(info.sectionKey, currentItem)"
          />
          <q-btn
            label="Edit"
            v-else
            color="primary"
            @click="updateItem(info.sectionKey, currentItem)"
          />

          <q-btn label="Close" color="primary" @click="closeDialogBox" />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </q-card>
</template>

<script setup>
import { ref, unref } from "vue";
import { nanoid } from "nanoid";

// Import stores
import { useCanvasStore } from "../../stores/canvas";
import { useColorStore } from "../../stores/color";
// Instantiate our stores early so they are available
const canvas = useCanvasStore();
const colorStore = useColorStore();

const props = defineProps({
  // Canvas section definition
  info: Object,
  // The canvas name to use in looking up store data
  canvasName: String,
});

const currentItem = ref();

// console.log("INFO", props.info);

const id = ref("");
const add = ref(true);
const errorMessage = ref(null);
const dialogVisible = ref(false);
const itemInput = ref("");

const showEditItem = async (section, itemUid) => {
  currentItem.value = itemUid;
  add.value = false;
  errorMessage.value = null;
  dialogVisible.value = true;
  itemInput.value = canvas[props.canvasName][section].get(itemUid).text;
};

const updateItem = async (section, itemUid) => {
  canvas[props.canvasName][section].set(itemUid, {
    uid: itemUid,
    text: itemInput.value,
  }),
    closeDialogBox();
};

const deleteItem = async (section, itemUid) => {
  canvas[props.canvasName][section].delete(itemUid), closeDialogBox();
};

const addItem = async (section) => {
  const newUid = nanoid();

  console.log(canvas[props.canvasName][section] instanceof Map);

  if (canvas[props.canvasName][section] instanceof Map == false) {
    canvas[props.canvasName][section] = new Map();
  }

  canvas[props.canvasName][section].set(newUid, {
    uid: newUid,
    text: itemInput.value,
  });

  closeDialogBox();
};

function closeDialogBox() {
  currentItem.value = null;
  dialogVisible.value = false;
  add.value = true;
  itemInput.value = null;
}
</script>

<style lang="scss" scoped>
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
