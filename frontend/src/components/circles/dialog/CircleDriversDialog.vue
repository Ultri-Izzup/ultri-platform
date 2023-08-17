<template>
  <q-dialog ref="dialogRef" persistent>
    <q-card class="q-dialog-plugin">
      <q-form @submit="onSubmit" @reset="reset">
        <!-- Toolbar -->
        <q-bar class="bg-primary">
          {{ $t("circles.dialog.drivers.title") }}
          <q-space></q-space>
          <q-btn dense flat icon="mdi-close" v-close-popup @click="reset">
            <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
          </q-btn>
        </q-bar>
        <q-card-section>
          <div class="row q-pb-md">
            <q-input v-model="label" class="full-width" :label="$t('circles.dialog.drivers.label.label')"></q-input>
          </div>
          <div class="row q-pb-md">
            <q-input v-model="description" class="full-width" :label="$t('circles.dialog.drivers.description')"></q-input>
          </div>
          {{ $t('circles.dialog.drivers.internal') }} <q-toggle toggle-indeterminate v-model="source" :label="$t('circles.dialog.drivers.external')"></q-toggle>
        </q-card-section>
        <q-card-actions class="justify-center">
          <q-btn :label="$t('circles.dialog.drivers.saveDriver')" color="primary" @click="saveCircleDriver()"></q-btn>
          <q-btn :label="$t('circles.dialog.cancel')" color="primary" v-close-popup @click="reset"></q-btn>
        </q-card-actions>
      </q-form>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, computed, watch, unref } from "vue";
import { useDialogPluginComponent } from "quasar";
import { useCircleDriversStore } from "../../../stores/circleDrivers";

const circleDriversStore = useCircleDriversStore();

const label = ref(null)
const description = ref(null)
const source = ref(null)

const reset = () => {
  label.value = null;
  description.value = null;
  source.value = null;
};

const currentData = computed(() => {
  return circleDriversStore.current();
})

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
  console.log('Saving Driver')

  const driverObj = {
    label: unref(label),
    description: unref(description),
    source: unref(source)
  }

  const currentUid = await circleDriversStore.addDriver(driverObj);

  circleDriversStore.currentDriverUid = currentUid

  reset();
  onDialogOK();
}

</script>

<style scoped lang="scss"></style>
