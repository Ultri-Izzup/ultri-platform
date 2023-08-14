<template>
  <q-dialog ref="dialogRef" persistent>
    <q-card class="q-dialog-plugin">
      <q-form>
        <!-- Toolbar -->
        <q-bar class="dialog-qbar">
          {{ $t("circles.dialog.editor.title") }}
          <q-space></q-space>
          <q-btn
            dense
            flat
            icon="mdi-close"
            v-close-popup
            @click="closeDialog()"
          >
            <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
          </q-btn>
        </q-bar>
        <q-card-section>
          <div class="row q-pb-md">
            <q-input
              v-model="currentData.label"
              :label="$t('circles.circleName')"
              class="full-width"
            ></q-input>
          </div>
          <div v-if="currentData.parentCircle" class="row q-pb-md">
            <div class="col">
              <q-select
                v-model="currentData.parentCircle"
                map-options
                emit-value
                :options="circlesStore.circleSelections"
                :label="$t('circles.parentCircle')"
              ></q-select>
            </div>
          </div>
          <q-separator class="q-ma-md"/>

            <div class="row q-pb-md">
            <div class="col q-pr-xs">
              <q-select
                v-model="currentData.leaderUid"
                map-options
                emit-value
                :options="circleMembersStore.memberSelections"
                :label="$t('circles.roles.leader')"
              ></q-select>
            </div>
            <div class="col-2 q-pa-sm">
              <q-btn
                v-if="currentData.leaderUid"
                icon="mdi-minus"
                clickable
                @click="unassignRole(currentData.uid, 'leader')"
              ></q-btn>
              <q-btn
                v-else
                icon="mdi-plus"
                clickable
                @click="addMemberAs('leader')"
              ></q-btn>
            </div>
          </div>
          <div class="row q-pb-md">
            <div class="col q-pr-xs">
              <q-select
                v-model="currentData.delegateUid"
                map-options
                emit-value
                :options="circleMembersStore.memberSelections"
                :label="$t('circles.roles.delegate')"
              ></q-select>
            </div>
            <div class="col-2 q-pa-sm">
              <q-btn
                v-if="currentData.delegateUid"
                icon="mdi-minus"
                clickable
                @click="unassignRole(currentData.uid, 'delegate')"
              ></q-btn>
              <q-btn
                v-else
                icon="mdi-plus"
                clickable
                @click="addMemberAs('delgate')"
              ></q-btn>
            </div>
          </div>
          <div class="row q-pb-md">
            <div class="col q-pr-xs">
              <q-select
                v-model="currentData.secretaryUid"
                map-options
                emit-value
                :options="circleMembersStore.memberSelections"
                :label="$t('circles.roles.secretary')"
              ></q-select>
            </div>
            <div class="col-2 q-pa-sm">
              <q-btn
                v-if="currentData.secretaryUid"
                icon="mdi-minus"
                clickable
                @click="unassignRole(currentData.uid, 'secretary')"
              ></q-btn>
              <q-btn
                v-else
                icon="mdi-plus"
                clickable
                @click="addMemberAs('secretary')"
              ></q-btn>
            </div>
          </div>
          <div class="row q-pb-md">
            <div class="col q-pr-xs">
              <q-select
                v-model="currentData.facilitatorUid"
                map-options
                emit-value
                :options="circleMembersStore.memberSelections"
                :label="$t('circles.roles.facilitator')"
              ></q-select>
            </div>
            <div class="col-2 q-pa-sm">
              <q-btn
                v-if="currentData.facilitatorUid"
                icon="mdi-minus"
                clickable
                @click="unassignRole(currentData.uid, 'facilitator')"
              ></q-btn>
              <q-btn
                v-else
                icon="mdi-plus"
                clickable
                @click="addMemberAs('facilitator')"
              ></q-btn>
            </div>
          </div>
        </q-card-section>
        <q-card-actions class="justify-center">
          <q-btn
            v-if="currentData.parentCircle"
            :label="$t('circles.dialog.delete')"
            color="primary"
            @click="deleteCircle()"
          ></q-btn>
          <q-space></q-space>
          <q-btn
            :label="$t('circles.dialog.addChild')"
            color="primary"
            @click="addChild()"
          ></q-btn>
          <q-btn
            :label="$t('controls.close')"
            color="primary"
            @click="closeDialog()"
          ></q-btn>
        </q-card-actions>
      </q-form>
    </q-card>
    <AssignedMemberDialog
      v-model="circleMembersStore.showAssignedMemberDialog"
      :role="currentRole"
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
});

const emit = defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  ...useDialogPluginComponent.emits,
  "closing",
]);

const onSubmit = async () => {};

const { dialogRef, onDialogOK, onDialogCancel, onDialogHide } =
  useDialogPluginComponent();

const deleteCircle = () => {
  circlesStore.deleteCurrent();
  onDialogOK();
};

const addChild = () => {
  console.log("Adding child to: " + circlesStore.currentCircleUid);
  circlesStore.triggerChildCircleDialog();
};

const closeDialog = () => {
  emit("closing", true);
  reset();
  onDialogCancel();
};

const onSave = async () => {
  submitted.value = true;
};

const onReset = () => {
  currentData.value = [];
};

const addMemberAs = async (role) => {
  currentRole.value = role;
  circleMembersStore.triggerAssignedMemberDialog();
};

const unassignRole = (circleUid, role) => {
  currentData.value[role + "Uid"] = null;
  circlesStore.unassignRole(circleUid, role);
};
</script>

<style scoped lang="scss"></style>
