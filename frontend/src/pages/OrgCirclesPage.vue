<template>
  <q-page>
    <div class="text-h3 text-center justify-center row full-width">
      {{ $t("circles.dashboard.title") }}
    </div>
    <div class="fit">
      <div v-if="hasCircles">
        <div class="row">
          <!-- <pre>{{ treeData }}</pre> -->
          <div class="col-12">
            <q-btn
              :label="$t('circles.reset.button.text')"
              color="primary"
              @click="circlesStore.$reset()"
            ></q-btn
            >
            <q-tree
              :nodes="treeData"
              node-key="uid"
              v-model:selected="selected"
              default-expand-all
            ></q-tree>
          </div>
        </div>
      </div>
      <div v-else>
        <q-btn
          :label="$t('circles.firstCircle.button.text')"
          color="primary"
          @click="circlesStore.initCircles()"
        ></q-btn>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { onMounted, computed, ref, watch } from "vue";

import { arrayToTree } from "performant-array-to-tree";

import { useCirclesStore } from "../stores/circles";

const circlesStore = useCirclesStore();

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

// Load circle data for the org into the store
//circlesStore.triggerCircleDialog();

onMounted(() => {});
</script>

<style lang="scss"></style>
