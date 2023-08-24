<template>
  <q-dialog ref="dialogRef">
    <q-card>
      <q-bar class="bg-primary">
        New Canvas Section
        <q-space></q-space>
        <q-btn dense flat icon="mdi-close" v-close-popup @click="resetNew()">
          <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
        </q-btn>
      </q-bar>
      <q-card-section>
        <q-input label="Title" v-model="edit.title" />
        <div class="q-pt-sm q-pb-xs text-caption text-grey-8">Instructions</div>
         <q-editor
          v-model="edit.instructions"
          min-height="5rem"
          label="Instructions"
        ></q-editor>
         <q-input label="Key" v-model="edit.sectionKey" />
        <q-input label="Sequence (opt)" v-model="edit.sequence" />
        <UColumnSelector v-model="edit.gridColumn" />
        <URowSelector v-model="edit.gridRow" />
      </q-card-section>
      <q-card-actions class="justify-center">
        <q-btn label="Save" color="primary" @click="save()"></q-btn>
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref } from "vue";
import { useDialogPluginComponent } from "quasar";

import { v4 as uuidv4 } from "uuid";

import UColumnSelector from "../../ultri/UColumnSelector.vue";
import URowSelector from "../../ultri/URowSelector.vue";

const emit = defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  ...useDialogPluginComponent.emits,
  "save",
]);

const props = defineProps({
  sectionData: {
    type: Object,
    default(rawProps) {
      return { instructions: ''}
    }
  }
});

const edit = ref(props.sectionData);


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

const save = () => {
  emit('save', edit.value);
  reset();
  onDialogOK();
}

const reset = () => {
  edit.value = {}
}

</script>
