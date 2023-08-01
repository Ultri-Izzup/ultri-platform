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
      {{info}}
      {{canvas[canvasName][info.sectionKey]}}
      <q-item
        v-for="[k, item] in canvas[canvasName][info.sectionKey]" :key="k"
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

// Import stores
import { useCanvasStore } from "../../stores/canvas";
// Instantiate our stores early so they are available
const canvas = useCanvasStore();

const props = defineProps({
  // Canvas section definition
  info: Object,
  // The canvas name to use in looking up store data
  canvasName: String
});

console.log('INFO', props.info)

const id = ref("");
const currentItem = ref();
const add = ref(true);
const errorMessage = ref(null);
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
