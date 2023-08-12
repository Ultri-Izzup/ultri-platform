<template>
  <div class="col">
    <q-card>
        <q-toolbar :class="colorStore.darkMode ? 'bg-grey-9' : ' bg-primary ' + ' text-white '">
          <q-toolbar-title>{{ $t("circles.circles") }}</q-toolbar-title>
          <q-btn
            v-if="Screen.lt.md"
            @click="showContent = !showContent"
            dense
            :icon="showContent ? 'mdi-chevron-up' : 'mdi-chevron-down'"
            :class="colorStore.darkMode ? 'bg-dark q-mr-sm' : 'bg-white text-primary q-mr-sm'"
            size="sm"
          />
          <q-btn
            @click="circlesStore.triggerNewCircleDialog()"
            dense
            icon="mdi-plus"
            :class="colorStore.darkMode ? 'bg-dark' : 'bg-white text-primary'"
            size="sm"
          />
        </q-toolbar>
        <q-card-section v-if="circlesStore.hasCircles &&  (showContent || Screen.gt.sm)">
          <q-tree
            :nodes="treeData"
            node-key="uid"
            v-model:selected="selected"
            default-expand-all
          ></q-tree>
        </q-card-section>
        <q-card-section v-if="!circlesStore.hasCircles" class="text-center justify-center">
          <q-btn
            :label="$t('circles.firstCircle.button.text')"
            color="primary"
            @click="circlesStore.initCircles()"
          >
          </q-btn>
        </q-card-section>
    </q-card>

    <CircleEditorDialog v-model="circlesStore.showCircleEditorDialog" @closing="handleClose()" />
    <NewCircleDialog
      v-model="circlesStore.showNewCircleDialog"
    />
    <ChildCircleDialog
      v-model="circlesStore.showChildCircleDialog"
    />
  </div>
</template>

<script setup>
import { computed, ref, watch } from "vue";
import { arrayToTree } from "performant-array-to-tree";

import { useCirclesStore } from "../../stores/circles";
// import { useCircleMembersStore } from "../../stores/circleMembers";
import { useColorStore } from "../../stores/color";

import { Screen } from "quasar";

import CircleEditorDialog from "./dialog/CircleEditorDialog.vue";
import NewCircleDialog from "./dialog/NewCircleDialog.vue";
import ChildCircleDialog from "./dialog/ChildCircleDialog.vue";

const circlesStore = useCirclesStore();
//const circleMembersStore = useCircleMembersStore();
const colorStore = useColorStore();

const showContent = ref(true);

const selected = ref(null);

const unselectNode = () => {
  selected.value = null;
};

const handleClose = () => {
  console.log('handling emitted close event')
  unselectNode();
}

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


watch(selected, () => {
  const selectedState = selected.value ? "selected" : "unselected";
  console.log("SELECTION CHANGED", selectedState, selected.value);
  if (selectedState == "selected") {
    circlesStore.currentCircleUid = selected.value;
    circlesStore.triggerCircleEditorDialog();
  } else {
    circlesStore.currentCircleUid = null;
  }
});
</script>

<style lang="scss"></style>

