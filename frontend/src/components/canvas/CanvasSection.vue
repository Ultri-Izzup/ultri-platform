<template>
  <q-card class="container-card" :class="info.class">
    <q-card-section class="top-q-card">
      <p>{{ info.title }}</p>
      <q-icon
        name="mdi-plus-circle-outline"
        size="20px"
        @click="dialogVisible = true"
      ></q-icon>
    </q-card-section>
    <q-separator></q-separator>
    <q-list separator>
      <q-item
        v-for="item in editable"
        :key="item.key"
        clickable
        class="q-pa-sm items-center"
        @click="editToList(item)"
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
        <q-input v-model.trim="qinput" class="input"></q-input>
        <q-banner
          class="bg-red text-white q-pa-sm q-mt-sm text-center"
          v-if="errorMessage"
          >Please add more characters</q-banner
        >
        <q-card-actions align="evenly">
          <!-- Dialog actions (buttons) go here -->
          <q-btn
            label="add"
            v-if="add"
            color="primary"
            @click="addToList(info.key)"
          />
          <q-btn
            label="Edit"
            v-else
            color="primary"
            @click="updateList(info)"
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

const props = defineProps({
  info: Object,
  currentData: Object,
  addItem: Function,
  editItemToList: Function,
});

const editable = unref(props.currentData);

console.log(props.currentData);

function addToList(key) {
  add.value = true;
  if (qinput.value.length < 2) {
    errorMessage.value = true;
    return;
  }

  editable.push({ uid: nanoid(), text: qinput.value });
  qinput.value = "";
  errorMessage.value = null;
  dialogVisible.value = false;
}

function updateList(item) {
  add.value = false;
  if (qinput.value.length < 2) {
    errorMessage.value = true;
    return;
  }

  console.log('Key', item)
  //const editIx = editable.findIndex(item => item.uid = key)
  //console.log(editIx)

  editable.push({ uid: nanoid(), text: qinput.value });

  qinput.value = "";
  errorMessage.value = null;
  dialogVisible.value = false;
}

function editToList(item) {
  add.value = false;
  dialogVisible.value = true;
  qinput.value = item.text;
  id.value = item.id;
}
function closeDialogBox() {
  dialogVisible.value = false;
  add.value = true;
  qinput.value = "";
}
function publishEdit() {
  dialogVisible.value = false;
  id.value = "";
  qinput.value = "";
  add.value = true;
}

const id = ref("");
const currentItem = ref();
const add = ref(true);
const errorMessage = ref(null);
const listToRender = ref(props.info.listToRender);
const dialogVisible = ref(false);
const qinput = ref("");
</script>

<style scoped>
::-webkit-scrollbar {
  display: none;
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
}
.q-dialog .q-card {
  min-width: 350px;
}
.input {
  width: 100%;
  padding: 0 20px;
}
</style>
