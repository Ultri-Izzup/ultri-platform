<template>
  <q-dialog ref="dialogRef" persistent>
    <q-card class="q-dialog-plugin">
      <q-form @submit="onSubmit" @reset="onReset">
        <q-bar class="dialog-qbar">
          {{  $t('orgs.dialog.missionStatement.title') }}
          <q-space></q-space>

          <q-btn dense flat icon="mdi-close" v-close-popup @click="auth.setTargetUrl(null)">
            <q-tooltip>{{$t('nav.close')}} </q-tooltip>
          </q-btn>
        </q-bar>
        <q-card-section>
          <div class="dialog-header row">
            <div class="col">
              {{ $t('orgs.dialog.missionStatement.form.title') }}
            </div>
          </div>
          <div class="dialog-body">
            {{ $t('orgs.dialog.missionStatement.form.body') }}
          </div>
        </q-card-section>
        <q-card-section>
          <q-input
            :label="$t('orgs.dialog.missionStatement.form.hint')"
            v-model="mission"
            autogrow
          ></q-input>
          </q-card-section>
        <!-- buttons example -->
        <q-card-actions align="center">
          <q-btn
            icon="mdi-content-save"
            color="primary"
            type="submit"
            :label="$t('controls.save')"
            :disable="!submitEnabled"
          ></q-btn>
        </q-card-actions>
      </q-form>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, computed, watch } from 'vue';
import { useDialogPluginComponent } from 'quasar';
import { useRouter } from 'vue-router';

import { useOrgStore } from '../../../stores/org';

import { useI18n } from "vue-i18n";

const { t } = useI18n();

const org = useOrgStore();

const props = defineProps({});

const router = useRouter();

const nuggetType = ref(null)

const mission = ref(null);
const submitted = ref(false);
const validMission = ref(false);
const submitEnabled = computed(() => {
  return mission.value && ! submitted.value ? true : false;
});


const reset = () => {
  mission.value = null;
  submitted.value = false;
};

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

const onSubmit = async () => {
  submitted.value = true;
  const resultData = await org.setOrgMission(org.currentOrgUid, mission.value);
};

const onReset = () => {
  mission.value = null;
};

watch(mission, (newValue, oldValue) => {
  if (org.validateMission(newValue)) {
    validMission.value = true;
  } else {
    validMission.value = false;
  }
});

</script>

<style scoped lang="scss"></style>
