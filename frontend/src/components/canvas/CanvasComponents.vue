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
        v-for="item in listToRender"
        :key="item.id"
        clickable
        class="q-pa-sm items-center"
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
        <q-input class="input"></q-input>
        <q-card-actions align="evenly">
          <!-- Dialog actions (buttons) go here -->
          <q-btn label="add" color="primary" @click="dialogVisible = false" />
          <q-btn label="Close" color="primary" @click="dialogVisible = false" />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </q-card>
</template>

<script setup>
import { ref } from "vue";
const props = defineProps({
  info: Object,
});
const listToRender = ref(props.info.listToRender);
const dialogVisible = ref(false);
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
