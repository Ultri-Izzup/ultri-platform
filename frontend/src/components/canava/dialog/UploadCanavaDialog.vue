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

const emit = defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  ...useDialogPluginComponent.emits,
  'uploaded'
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
  console.log(canvasData);

  emit('uploaded', canvasData);

  onDialogOK();

};
</script>
