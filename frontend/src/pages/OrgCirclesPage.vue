<template>
  <q-page>
    <div class="text-h3 text-center justify-center row full-width q-pb-md">
      {{ $t("circles.dashboard.title") }}
    </div>

    <div class="row full-width">
      <div class="col-4">
        <CircleMembersEditor />
      </div>
      <div class="col-8">
        <CirclesEditor />
      </div>
    </div>

    <div class="fit">
      <div>
        <q-page-sticky
          :position="Screen.gt.sm ? 'bottom-right' : 'bottom'"
          :offset="fabPos"
          class="ontop"
        >
          <q-fab
            icon="mdi-file-arrow-up-down-outline"
            direction="up"
            color="accent"
            :disable="draggingFab"
            v-touch-pan.prevent.mouse="moveFab"
            class="ontop"
          >
            <q-fab-action
              @click="onDownloadClick()"
              color="primary"
              icon="mdi-download"
              :disable="draggingFab || circlesStore.orgCircles.length < 1"
              class="ontop"
            ></q-fab-action>
            <q-fab-action
              @click="onUploadClick"
              color="primary"
              icon="mdi-upload"
              :disable="draggingFab"
              class="ontop"
            >
            </q-fab-action>
            <q-fab-action
              @click="onDeleteClick()"
              color="secondary"
              icon="mdi-delete"
              :disable="draggingFab || circlesStore.orgCircles.length < 1"
              class="ontop"
            ></q-fab-action>
          </q-fab>
        </q-page-sticky>
        <a id="downloadAnchorElem" style="display: none"></a>
        <UploadCirclesDialog v-model="displayUpload" />
      </div>
    </div>
    <CirclesDialog v-model="circlesStore.showCirclesDialog"></CirclesDialog>
    <NewCircleDialog
      v-model="circlesStore.showNewCircleDialog"
    ></NewCircleDialog>
    <ChildCircleDialog
      v-model="circlesStore.showChildCircleDialog"
    ></ChildCircleDialog>
  </q-page>
</template>

<script setup>
import { onMounted, computed, ref, watch } from "vue";
import { arrayToTree } from "performant-array-to-tree";

import { useCirclesStore } from "../stores/circles";
import { useCircleMembersStore } from "../stores/circleMembers";
import { useOrgStore } from "../stores/org";

import { Screen } from "quasar";

import CirclesDialog from "../components/circles/dialog/CirclesDialog.vue";
import NewCircleDialog from "../components/circles/dialog/NewCircleDialog.vue";
import ChildCircleDialog from "../components/circles/dialog/ChildCircleDialog.vue";
import UploadCirclesDialog from "../components/circles/dialog/UploadCirclesDialog.vue";

import CirclesEditor from "../components/circles/CirclesEditor.vue";

const orgStore = useOrgStore();
const circlesStore = useCirclesStore();
const circleMembersStore = useCircleMembersStore();

// FAB - Floating Action Button to save/download
const fabPos = ref([18, 18]);
const draggingFab = ref(false);

const displayUpload = ref(false);

const onUploadClick = () => {
  console.log("Upload Data for " + orgStore.currentOrgUid);
  // Display dialog
  displayUpload.value = true;
};
const onDeleteClick = () => {
  console.log("Delete All Data for " + orgStore.currentOrgUid);
  circlesStore.clear();
};
const onDownloadClick = () => {
  console.log("Download Data for " + orgStore.currentOrgUid);

  // Define an object to hold our ouput
  const outObj = { circles: {} };

  outObj.circles = circlesStore.orgCircles;

  var dataStr =
    "data:text/json;charset=utf-8," +
    encodeURIComponent(JSON.stringify(outObj, 0, 2));
  var dlAnchorElem = document.getElementById("downloadAnchorElem");
  dlAnchorElem.setAttribute("href", dataStr);
  dlAnchorElem.setAttribute(
    "download",
    "OpenSociocracy-Circles.json"
  );
  dlAnchorElem.click();

  console.log(outObj);
};
const moveFab = (ev) => {
  draggingFab.value = ev.isFirst !== true && ev.isFinal !== true;
  fabPos.value = [fabPos.value[0] - ev.delta.x, fabPos.value[1] - ev.delta.y];
};
</script>

<style lang="scss"></style>
