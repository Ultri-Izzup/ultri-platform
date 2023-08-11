<template>
  <q-dialog ref="dialogRef" persistent>
    <q-card class="q-dialog-plugin">
      <q-form @submit="onSubmit" @reset="onReset">
        <!-- Toolbar -->
        <q-bar class="dialog-qbar">
          {{ $t("circles.dialog.editor.title") }}
          <q-space></q-space>
          <q-btn dense flat icon="mdi-close" v-close-popup @click="reset">
            <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
          </q-btn>
        </q-bar>
        <q-card-section>
          <div class="row q-pb-md">
            <q-input v-model="currentData.label" :label="$t('circles.circleName')" class="full-width"></q-input>

          </div>
          <!-- <div class="row q-pb-md">
            <div class="col text-grey-7">
              ID: {{circlesStore.current('uid') }}
            </div>
          </div> -->

          <div class="row">
              <div class="col">
              <q-select filled v-model="currentData.parentCircle" map-options emit-value :options="circlesStore.circleSelections" :label="$t('circles.parentCircle')"></q-select>
            </div>
          </div>
        </q-card-section>
        <q-card-actions class="justify-center">
          <q-btn :label="$t('circles.dialog.addChild')" color="primary" @click="addChild()"></q-btn>
          <q-btn :label="$t('circles.dialog.delete')" color="primary" @click="deleteCircle()"></q-btn>
          <q-btn :label="$t('controls.close')" color="primary" @click="onDialogOK();"></q-btn>
        </q-card-actions>
      </q-form>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, computed, watch, unref } from "vue";
import { useDialogPluginComponent } from "quasar";
import { useCirclesStore } from "../../../stores/circles";

const circlesStore = useCirclesStore();

const reset = () => {};

const currentData = computed(() => {
  return circlesStore.current();
})

// currentData.value = circlesStore.current();

// watch(circlesStore.currentCircleUid, (newValue, oldValue) => {
//   currentData.value = circlesStore.current();
// });

defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  //...useDialogPluginComponent.emits,
  "ok",
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

const deleteCircle = () => {
  circlesStore.deleteCurrent();
  onDialogOK();
}

const addChild = () => {
  console.log('Adding child to: ' + circlesStore.currentCircleUid)
  circlesStore.triggerChildCircleDialog();
}


const onSave = async () => {
  submitted.value = true;
};

const onReset = () => {
  currentData.value = []
};
</script>

<style scoped lang="scss"></style>
