<template>
  <q-dialog ref="dialogRef" maximize>
    <q-card>
      <q-bar class="bg-primary">
        {{data.title}} Item
        <q-space></q-space>
        <q-btn

          dense
          flat
          icon="mdi-delete"
          v-close-popup
          @click="emit('remove', )"
          class="q-pr-sm"
        >
          <q-tooltip>{{ $t("nav.delete") }} </q-tooltip>
        </q-btn>
        <q-btn dense flat icon="mdi-close" v-close-popup @click="reset()">
          <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
        </q-btn>
      </q-bar>
      <q-card-section>     {{ data }} </q-card-section>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, watch, toRefs, toRef, reactive } from "vue";
import { useDialogPluginComponent, useQuasar } from "quasar";

import { v4 as uuidv4 } from "uuid";

const emit = defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  ...useDialogPluginComponent.emits,
  "add",
  "modify",
  "remove",
]);

const props = defineProps(["data"]);

const edit = reactive({});

const $q = useQuasar();

// watch(
//   () => props.data,
//   () => {
//     edit.value = reactive(props.data);
//   },
//   { immediate: true }
// );

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
  if (edit.value.uid) {
    // Update
    emit("modify", edit.value);
  } else {
    // New
    console.log("NEW");
    edit.value.uid = uuidv4();
    emit("add", edit.value);
  }
  reset();
  onDialogOK();
};

const reset = () => {
  //edit.value = {};
};
</script>
