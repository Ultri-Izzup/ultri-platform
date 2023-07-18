<template>
  <q-dialog ref="dialogRef" persistent>
    <q-card class="q-dialog-plugin">
      <q-bar class="dialog-qbar">
        <q-space></q-space>
        <q-btn
          dense
          flat
          icon="mdi-close"
          v-close-popup
          @click="auth.notNewMember()"
        >
          <q-tooltip>{{ $t('nav.close') }}</q-tooltip>
        </q-btn>
      </q-bar>
      <q-card-section>
        <div class="dialog-header row">
          <div class="col">
            {{ $t('member.welcome.headline')}}
          </div>
        </div>
        <div class="dialog-body">
          {{ $t('member.welcome.body')}}
        </div>
      </q-card-section>
    </q-card>
  </q-dialog>
</template>

<script setup language="ts">
import { useDialogPluginComponent } from 'quasar';

import { useAuthStore } from '../stores/auth';
const auth = useAuthStore();

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
</script>

<style scoped lang="scss"></style>
