<template>
    <div class="row">
      <!-- <pre>{{ treeData }}</pre> -->
      <!-- {{ circleMembersStore.members }} -->
      <div class="row full-width">
        <div>
          <q-toolbar
          :class="colorStore.darkMode ? 'bg-dark' : 'bg-primary text-white'"
        >
          <q-toolbar-title>Members</q-toolbar-title>
          <q-btn
            dense
            icon="mdi-plus"
            :class="colorStore.darkMode ? 'bg-grey-9' : 'bg-white text-primary'"
          />
        </q-toolbar>
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
import { useColorStore } from "../stores/color";

import { Screen } from "quasar";

import CirclesDialog from "../components/circles/dialog/CirclesDialog.vue";
import NewCircleDialog from "../components/circles/dialog/NewCircleDialog.vue";
import ChildCircleDialog from "../components/circles/dialog/ChildCircleDialog.vue";

import UploadCirclesDialog from "../components/circles/dialog/UploadCirclesDialog.vue";

const orgStore = useOrgStore();
const circlesStore = useCirclesStore();
const colorStore = useColorStore();
const circleMembersStore = useCircleMembersStore();

const selected = ref(null);

const unselectNode = () => {
  selected.value = null;
};

const hasCircles = computed(() => {
  return circlesStore.orgCircles.length;
});

const treeData = computed(() => {
  let tree = [];
  tree = arrayToTree(circlesStore.orgCircles, {
    id: "uid",
    parentId: "parentCircle",
    childrenField: "children",
    dataField: null,
  });

  return tree;
});

``;
</script>

<style lang="scss"></style>
