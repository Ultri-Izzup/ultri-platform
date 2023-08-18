<template>
  <q-dialog ref="dialogRef" persistent>
    <q-card class="q-dialog-plugin">
      <q-form>
        <!-- Toolbar -->
        <q-bar class="bg-primary">
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

        <!-- CIRCLE BASICS -->
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
        </q-card-section>

        <!-- CIRCLE DETAILS -->
        <q-card-section>
          <q-list border>
            <!-- MISSION STATEMENT -->
            <q-expansion-item
              v-if="!currentData.parentCircle"
              expand-separator
              icon="mdi-script-text"
              :label="$t('circles.dialog.editor.mission.label')"
              :caption="$t('circles.dialog.editor.mission.caption')"
              group="circle-editor"
              header-class="text-body1"
            >
              <div class="row q-pb-md">
                <q-input
                  v-model="currentData.missionStatement"
                  :label="$t('circles.dialog.editor.mission.label')"
                  autogrow
                  class="full-width"
                ></q-input>
              </div>
            </q-expansion-item>

            <!-- DOMAIN DESCRIPTION -->
            <q-expansion-item
              expand-separator
              icon="mdi-domain"
              :label="$t('circles.dialog.editor.domain.label')"
              :caption="$t('circles.dialog.editor.domain.caption')"
              group="circle-editor"
              header-class="text-body1"
            >
              <div class="row q-pb-md">
                <q-input
                  v-model="currentData.domain"
                  :label="$t('circles.dialog.editor.domain.label')"
                  autogrow
                  class="full-width"
                ></q-input>
              </div>
            </q-expansion-item>

            <!-- CIRCLE ROLES -->
            <q-expansion-item
              expand-separator
              icon="mdi-account-supervisor"
              :label="$t('circles.dialog.editor.roles.label')"
              :caption="$t('circles.dialog.editor.roles.caption')"
              group="circle-editor"
              header-class="text-body1"
            >
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
            </q-expansion-item>

            <!-- DRIVERS -->
            <q-expansion-item
              expand-separator
              icon="mdi-sign-direction"
              :label="$t('circles.dialog.editor.drivers.label')"
              :caption="$t('circles.dialog.editor.drivers.caption')"
              group="circle-editor"
              header-class="text-body1"
            >
              <div class="row bg-primary q-pa-xs">
                <q-space />
                <q-btn
                  @click="circleDriversStore.triggerCircleDriverDialog()"
                  dense
                  icon-right="mdi-plus"
                  size="sm"
                  clickable
                  v-ripple
                  :label="$t('circles.dialog.editor.newDriver')"
                  class="q-pl-sm"
                ></q-btn>
              </div>
              <div class="row q-pb-md">
                <div
                  v-for="driver in circlesStore.circleDrivers(
                    circlesStore.currentCircleUid
                  )"
                  :key="driver"
                  class="row full-width"
                >
                  <CircleDriverInlineEditor
                    :driverUid="driver"
                    @unlink="
                      circlesStore.unlinkDriver(
                        circlesStore.currentCircleUid,
                        driver
                      )
                    "
                  />
                </div>
              </div>
            </q-expansion-item>

            <!-- OKR -->
            <q-expansion-item
              expand-separator
              icon="mdi-flag-checkered"
              :label="$t('circles.dialog.editor.okr.label')"
              :caption="$t('circles.dialog.editor.okr.caption')"
              group="circle-editor"
            >
              <div class="row bg-primary q-pa-xs">
                <q-space />
                <q-btn
                  @click="circleOKRStore.triggerCircleOKRDialog()"
                  dense
                  icon-right="mdi-plus"
                  size="sm"
                  clickable
                  v-ripple
                  :label="$t('circles.dialog.editor.newOKR')"
                  class="q-pl-sm"
                ></q-btn>
              </div>
              <div class="row q-pb-md">
                <div
                  v-for="okr in circlesStore.circleOKR(
                    circlesStore.currentCircleUid
                  )"
                  :key="okr"
                  class="row full-width"
                >
                  <CircleOKRInlineEditor
                    :okrUid="okr"
                    @unlink="
                      circlesStore.unlinkOKR(
                        circlesStore.currentCircleUid,
                        okr
                      )
                    "
                  />
                </div>
              </div>
            </q-expansion-item>
          </q-list>
        </q-card-section>

        <!-- ACTIONS -->
        <q-card-actions class="justify-center">
          <q-space />
          <q-btn
            v-if="currentData.parentCircle"
            :label="$t('circles.dialog.delete')"
            color="secondary"
            @click="deleteCircle()"
          ></q-btn>
          <q-space />
          <q-btn
            :label="$t('circles.dialog.addChild')"
            color="primary"
            @click="addChild()"
          ></q-btn>
          <q-space />
          <q-btn
            :label="$t('controls.close')"
            color="secondary"
            @click="closeDialog()"
          ></q-btn>
          <q-space />
        </q-card-actions>
      </q-form>
    </q-card>

    <!-- DIALOGS -->
    <AssignedMemberDialog
      v-model="circleMembersStore.showAssignedMemberDialog"
      :role="currentRole"
    ></AssignedMemberDialog>
    <CircleDriverDialog
      v-model="circleDriversStore.showCircleDriverDialog"
    ></CircleDriverDialog>
    <CircleOKRDialog
      v-model="circleOKRStore.showCircleOKRDialog"
    ></CircleOKRDialog>
    <CircleKeyResultDialog
      v-model="circleOKRStore.showCircleKeyResultDialog"
    ></CircleKeyResultDialog>
  </q-dialog>
</template>

<script setup>
import { ref, computed, watch, unref } from "vue";
import { useDialogPluginComponent } from "quasar";
import { useCirclesStore } from "../../../stores/circles";
import { useCircleMembersStore } from "../../../stores/circleMembers";
import { useCircleDriversStore } from "../../../stores/circleDrivers";
import { useCircleOKRStore } from "../../../stores/circleOKR";

import AssignedMemberDialog from "./AssignedMemberDialog.vue";
import CircleDriverDialog from "./CircleDriverDialog.vue";
import CircleOKRDialog from "./CircleOKRDialog.vue";
import CircleKeyResultDialog from "./CircleKeyResultDialog.vue";
import CircleDriverInlineEditor from "../driver/CircleDriverInlineEditor.vue";
import CircleOKRInlineEditor from "../okr/CircleOKRInlineEditor.vue";

const circlesStore = useCirclesStore();
const circleMembersStore = useCircleMembersStore();
const circleDriversStore = useCircleDriversStore();
const circleOKRStore = useCircleOKRStore();

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
