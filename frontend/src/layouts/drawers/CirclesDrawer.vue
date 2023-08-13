<template>
  <div>
    <q-toolbar class="bg-primary text-white shadow-2">
      <q-toolbar-title>Circles / Members</q-toolbar-title>
    </q-toolbar>
    <q-list>

    </q-list>
  </div>
</template>

<script setup>
import { ref } from "vue";

import OrgTreeGraph from "../../components/graphs/OrgTreeGraph.vue";
import D3ForcedGraph from "../../components/graphs/D3ForcedGraph.vue";
import { useRoute } from "vue-router";
const route = useRoute();

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
