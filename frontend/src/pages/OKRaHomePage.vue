<template>
  <q-page>
    <div class="text-h3 text-center justify-center row full-width q-pb-md">
      {{ $t("cirkel.dashboard.title", 'OKRa') }}
    </div>

    <div class="row full-width">

      <div :class="Screen.lt.md ? ' col-12 q-px-md q-pb-md' : ' col-8 q-pl-md q-pr-sm'">
        benefits
      </div>

      <div :class="Screen.lt.md ? ' col-12 q-px-md q-pb-md' : ' col-4 q-pr-md q-pl-sm'">
        Coming soon
      </div>

    </div>

  </q-page>
</template>

<script setup>
import { ref } from "vue";

import { useCirclesStore } from "../stores/circles";
import { useCircleMembersStore } from "../stores/circleMembers";
import { useOrgStore } from "../stores/org";

import { Screen } from "quasar";

import UploadCirclesDialog from "../components/circles/dialog/UploadCirclesDialog.vue";

import CirclesTree from "../components/circles/CirclesTree.vue";
import CircleMembersList from "../components/circles/CircleMembersList.vue";

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
  circlesStore.$reset();
  circleMembersStore.$reset();
};
const onDownloadClick = () => {
  console.log("Download Data for " + orgStore.currentOrgUid);

  // Define an object to hold our ouput
  const outObj = { circles: [], members: [] };

  outObj.circles = circlesStore.orgCircles;

  outObj.members = circleMembersStore.members;

  var dataStr =
    "data:text/json;charset=utf-8," +
    encodeURIComponent(JSON.stringify(outObj, 0, 2));
  var dlAnchorElem = document.getElementById("downloadAnchorElem");
  dlAnchorElem.setAttribute("href", dataStr);
  dlAnchorElem.setAttribute(
    "download",
    "OpenSociocracy-circles.json"
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
