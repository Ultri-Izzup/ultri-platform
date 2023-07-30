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
    <ol></ol>
    <q-dialog v-model="dialogVisible">
      <q-card>
        <q-card-section>
          <!-- Dialog content goes here -->
          <p>This is a dialog content</p>
        </q-card-section>

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
</style>
