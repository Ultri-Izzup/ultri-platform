<template>
  <q-page>
    <OrgChartContainer :circles="treeData" :members="membersMap" />
  </q-page>
</template>

<script setup>

import { computed } from "vue";

import { arrayToTree } from "performant-array-to-tree";

import { useCirclesStore } from "../stores/circles";
import { useCircleMembersStore } from "../stores/circleMembers";

import OrgChartContainer from "../components/orgChart/OrgChartContainer.vue";

const circlesStore = useCirclesStore();
const circleMembersStore = useCircleMembersStore();

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

const membersMap = circleMembersStore.membersMap;

</script>

<style lang="scss" scoped>


</style>
