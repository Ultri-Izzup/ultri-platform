<template>
  <q-dialog ref="dialogRef" persistent>
    <q-card class="q-dialog-plugin">
      <q-form @submit="onSubmit" @reset="reset">
        <!-- Toolbar -->
        <q-bar class="bg-primary">
          {{ $t("circles.dialog.okrs.keyResults.title") }}
          <q-space></q-space>
          <q-btn dense flat icon="mdi-close" v-close-popup @click="reset">
            <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
          </q-btn>
        </q-bar>
        <q-card-section>
          <div class="row q-pb-md">
            <q-input
              v-model="label"
              class="full-width"
              :label="$t('circles.dialog.okrs.label.label')"
            ></q-input>
          </div>
          <div class="row q-pb-md">
            <q-input
              v-model="description"
              class="full-width"
              :label="$t('circles.dialog.okrs.description')"
            ></q-input>
          </div>
        </q-card-section>
        <q-card-actions class="justify-center">

          <q-space />
          <q-btn
            :label="$t('circles.dialog.okrs.saveKeyResult')"
            color="primary"
            @click="saveCircleKeyResult()"
          ></q-btn>
          <q-space />
          <q-btn
            :label="$t('circles.dialog.cancel')"
            color="secondary"
            v-close-popup
            @click="reset"
          ></q-btn>
          <q-space />
        </q-card-actions>
      </q-form>
    </q-card>
    <KeyResultDialog v-mode="showKeyResultDialog" />
  </q-dialog>
</template>

<script setup>
import { ref, unref } from "vue";
import { useDialogPluginComponent } from "quasar";
import { useCirclesStore } from "../../../stores/circles";
import { useCircleDriversStore } from "../../../stores/circleDrivers";

const circlesStore = useCirclesStore();
const circleOKRStore = useCircleDriversStore();

const label = ref(null);
const description = ref(null);
const keyResults = ref([]);
const showKeyResultDialog = ref(false);

const triggerKeyResultDialog = () => {

}

const reset = () => {
  label.value = null;
  description.value = null;
  keyResults.value = [];
  showKeyResultDialog.value = false;
};

defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  ...useDialogPluginComponent.emits,
  //
]);

const onSubmit = async () => {};

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

const saveCircleDriver = async () => {
  console.log("Saving Driver");

  const okrObj = {
    label: unref(label),
    description: unref(description),
    internal: unref(internal),
  };

  const okrUid = await circleDriversStore.addDriver(okrObj);

  console.log("Woot", okrUid);

  circlesStore.relateDriver(circlesStore.currentCircleUid, okrUid);

  reset();
  onDialogOK();
};

const triggerKeyResult = () => {};
</script>

<style scoped lang="scss"></style>
