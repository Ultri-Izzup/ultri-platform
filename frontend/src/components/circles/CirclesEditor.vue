<template>
  <div class="col">
    <q-card>
        <q-toolbar :class="colorStore.darkMode ? 'bg-grey-9' : ' bg-primary ' + ' text-white '">
          <q-toolbar-title>{{ $t("circles.circles") }}</q-toolbar-title>
          <q-btn
            @click="circlesStore.triggerNewCircleDialog()"
            dense
            icon="mdi-plus"
            :class="colorStore.darkMode ? 'bg-dark' : 'bg-white text-primary'"
          />
        </q-toolbar>
        <q-card-section v-if="circlesStore.hasCircles">
          <q-tree
            :nodes="treeData"
            node-key="uid"
            v-model:selected="selected"
            default-expand-all
          ></q-tree>
        </q-card-section>
        <q-card-section v-else class="text-center justify-center">
          <q-btn
            :label="$t('circles.firstCircle.button.text')"
            color="primary"
            @click="circlesStore.initCircles()"
          >
          </q-btn>
        </q-card-section>
    </q-card>

    <CirclesDialog v-model="circlesStore.showCirclesDialog"></CirclesDialog>
    <NewCircleDialog
      v-model="circlesStore.showNewCircleDialog"
    ></NewCircleDialog>
    <ChildCircleDialog
      v-model="circlesStore.showChildCircleDialog"
    ></ChildCircleDialog>
  </div>
</template>

<script setup>
import { computed, ref, watch } from "vue";
import { arrayToTree } from "performant-array-to-tree";

import { useCirclesStore } from "../../stores/circles";
import { useColorStore } from "../../stores/color";

import { Screen } from "quasar";

import CirclesDialog from "./dialog/CirclesDialog.vue";
import NewCircleDialog from "./dialog/NewCircleDialog.vue";
import ChildCircleDialog from "./dialog/ChildCircleDialog.vue";
import UploadCirclesDialog from "./dialog/UploadCirclesDialog.vue";

const circlesStore = useCirclesStore();
const colorStore = useColorStore();

const selected = ref(null);

const unselectNode = () => {
  selected.value = null;
};

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
    circlesStore.triggerCircleDialog();
  } else {
    circlesStore.currentCircleUid = null;
  }
});
</script>

<style lang="scss"></style>
