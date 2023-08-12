<template>
  <q-dialog ref="dialogRef" persistent>
    <q-card class="q-dialog-plugin">
      <q-form>
        <!-- Toolbar -->
        <q-bar class="dialog-qbar">
          {{ $t("circles.dialog.editor.title") }}
          <q-space></q-space>
          <q-btn dense flat icon="mdi-close" v-close-popup @click="closeDialog()">
            <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
          </q-btn>
        </q-bar>
        <q-card-section>
          <div class="row q-pb-md">
            <q-input  v-model="currentData.label" :label="$t('circles.circleName')" class="full-width"></q-input>

          </div>
          <!-- <div class="row q-pb-md">
            <div class="col text-grey-7">
              ID: {{circlesStore.current('uid') }}
            </div>
          </div> -->

          <div class="row  q-pb-md">
              <div class="col">
              <q-select  v-model="currentData.parentCircle" map-options emit-value :options="circlesStore.circleSelections" :label="$t('circles.parentCircle')"></q-select>
            </div>
          </div>
          <div class="row  q-pb-md">
              <div class="col q-pr-xs">
              <q-select v-model="currentData.leaderUid" map-options emit-value :options="circleMembersStore.memberSelections" :label="$t('circles.roles.leader')"></q-select>
            </div>
            <div class="col-2 q-pa-sm">
              <q-btn icon="mdi-plus" clickable @click="addMemberAs('leader')"></q-btn>
            </div>
          </div>

        </q-card-section>
        <q-card-actions class="justify-center">
          <q-btn :label="$t('circles.dialog.delete')" color="primary" @click="deleteCircle()"></q-btn>
          <q-space></q-space>
          <q-btn :label="$t('circles.dialog.addChild')" color="primary" @click="addChild()"></q-btn>
          <q-btn :label="$t('controls.close')" color="primary" @click="closeDialog()"></q-btn>
        </q-card-actions>
      </q-form>
    </q-card>
    <AssignedMemberDialog
      v-model="circleMembersStore.showAssignedMemberDialog" :role="currentRole"
    ></AssignedMemberDialog>
  </q-dialog>
</template>

<script setup>
import { ref, computed, watch, unref } from "vue";
import { useDialogPluginComponent } from "quasar";
import { useCirclesStore } from "../../../stores/circles";
import { useCircleMembersStore } from "../../../stores/circleMembers";

import AssignedMemberDialog from "./AssignedMemberDialog.vue";

const circlesStore = useCirclesStore();
const circleMembersStore = useCircleMembersStore();

const reset = () => {};

const currentRole = ref();

const currentData = computed(() => {
  return circlesStore.current();
})

// currentData.value = circlesStore.current();

// watch(circlesStore.currentCircleUid, (newValue, oldValue) => {
//   currentData.value = circlesStore.current();
// });

const emit = defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  ...useDialogPluginComponent.emits,
  "closing",
]);

const onSubmit = async () => {};

const { dialogRef, onDialogOK, onDialogCancel, onDialogHide } = useDialogPluginComponent();

const deleteCircle = () => {
  circlesStore.deleteCurrent();
  onDialogOK();
}

const addChild = () => {
  console.log('Adding child to: ' + circlesStore.currentCircleUid)
  circlesStore.triggerChildCircleDialog();
}

const closeDialog = () => {
  emit('closing', true);
  reset();
  onDialogCancel();
}


const onSave = async () => {
  submitted.value = true;
};

const onReset = () => {
  currentData.value = []
};

const addMemberAs = async (role) => {

  currentRole.value = role;

  circleMembersStore.triggerAssignedMemberDialog();


    //console.log(circleMembersStore.currentMemberUid);
    //circlesStore.setCircleRole(unref(circlesStore.currentCircleUid), role , unref(circleMembersStore.currentMemberUid));
}
</script>

<style scoped lang="scss"></style>
