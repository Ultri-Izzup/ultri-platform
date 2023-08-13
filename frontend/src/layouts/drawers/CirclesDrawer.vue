<template>
  <div>
    ORG CIRCLES
    <q-btn label="Organization Tree" @click="toggleOrgTreeDialog()"></q-btn>
    <q-btn label="Circles" @click="toggleD3ForcedDialog()"></q-btn>
    {{orgTreeVisible}}
    <OrgTreeGraph v-model="orgTreeVisible" />
    <D3ForcedGraph v-model="d3ForcedVisible" />
  </div>
</template>

<script setup>
import { ref } from "vue";

import OrgTreeGraph from "../../components/graphs/OrgTreeGraph.vue"
import D3ForcedGraph from "../../components/graphs/D3ForcedGraph.vue"

const orgTreeVisible = ref(false);
const d3ForcedVisible = ref(false);

const toggleOrgTreeDialog = () => {
  orgTreeVisible.value = !orgTreeVisible.value;
}
const toggleD3ForcedDialog = () => {
  d3ForcedVisible.value = !d3ForcedVisible.value;
}

</script>

<style lang="scss">
</style>
