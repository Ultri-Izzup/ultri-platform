<template>
  <div>
    <q-list>
      <q-expansion-item v-model="expanded" group="canvasSection" :label="info.title" header-class="text-bold">
        <q-list>
          <q-item>
            {{info.instructions}}
          </q-item>
        </q-list>
      </q-expansion-item>
    </q-list>
  </div>
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

const expanded = ref(false);

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

<style lang=scss scoped>
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
