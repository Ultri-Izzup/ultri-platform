<template id="u-dialog-prompt">
  <q-dialog ref="dialogRef">
    <q-card class="u-dialog q-dialog-plugin">
      <q-bar class="u-dialog-toolbar">
        {{ toolbarText }}
        <q-space></q-space>
        <q-btn dense flat icon="mdi-close" v-close-popup>
          <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
        </q-btn>
      </q-bar>
      <q-card-section>
        <div class="dialog-header row">
          <div class="row">
            {{ headlineText }}
          </div>
          <div class="dialog-instructions text-body1">
            {{ instructionsText }}
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <q-input :label="labelText" v-model="data"></q-input>
      </q-card-section>
      <q-card-actions class="justify-center">
        <q-btn :label="buttonText" color="primary" :disabled="validator(data)" @click="onDialogOK(data)"></q-btn>
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref } from "vue";
import { useDialogPluginComponent } from 'quasar';

const data = ref();

const props = defineProps({
  toolbarText: String,
  headlineText: String,
  instructionsText: String,
  labelText: String,
  buttonText: {
    type: String,
    default: 'Save'
  },
  validator: {
    type: Function,
    default: function (str='') {
        return str && ! str.length > 0;
      }
  }
});

const emit = defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  ...useDialogPluginComponent.emits,
]);

const { dialogRef, onDialogHide, onDialogOK, onDialogCancel } = useDialogPluginComponent();


</script>
