<template>
  <q-dialog ref="dialogRef" persistent>
    <q-card>
      <q-card-section style="min-width: 300px">
        <q-file
          v-model="selectedFile"
          accept=".json"
          max-file-size="500000"
          label="Select an exported canvas *.json file"
        ></q-file>
        <q-card-actions class="justify-center">
          <q-btn @click="performUpload" label="Upload" color="primary"></q-btn>
        </q-card-actions>
      </q-card-section>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref } from "vue";
import { useDialogPluginComponent } from 'quasar';

import { useCanvasStore } from "../../../stores/canvas";
import { emit } from "process";

defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  //...useDialogPluginComponent.emits,
  'ok',
]);

const { dialogRef, onDialogOK } = useDialogPluginComponent();
// dialogRef      - Vue ref to be applied to QDialog
// onDialogHide   - Function to be used as handler for @hide on QDialog
// onDialogOK     - Function to call to settle dialog with "ok" outcome
//                    example: onDialogOK() - no payload
//                    example: onDialogOK({ /*...*/ }) - with payload
// onDialogCancel - Function to call to settle dialog with "cancel" outcome

const onOKClick = () => {
  // on OK, it is REQUIRED to
  // call onDialogOK (with optional payload)
  onDialogOK();
  //primary.value = editPrimary.value;
  // or with payload: onDialogOK({ ... })
  // ...and it will also hide the dialog automatically
};

const canvasStore = useCanvasStore();

const selectedFile = ref(null);

const parseJsonFile = async (file) => {
  return new Promise((resolve, reject) => {
    const fileReader = new FileReader();
    fileReader.onload = (event) => resolve(JSON.parse(event.target.result));
    fileReader.onerror = (error) => reject(error);
    fileReader.readAsText(file);
  });
};

const performUpload = async () => {
  const canvasData = await parseJsonFile(selectedFile.value);
  console.log(canvasData.canvas);

  // Loop through canvas types
  for (const [canvasName, value] of Object.entries(canvasData.canvas)) {
    // Loop through canvas sections

    for (const [section, itemArr] of Object.entries(value)) {
      const items = new Map();
      console.log(section)
      console.log(itemArr)
      itemArr.forEach(item => {
        items.set(item.uid, item)
      });
      canvasStore.setCanvasData(canvasName, section, items);
    }

    onDialogOK();

  }
};
</script>
