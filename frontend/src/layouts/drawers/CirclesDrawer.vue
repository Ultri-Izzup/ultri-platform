<template>
  <div>
    <q-toolbar class="bg-primary text-white shadow-2">
      <q-toolbar-title>{{ $t("circles.drawer.label") }}</q-toolbar-title>
    </q-toolbar>
    <q-list>
      <q-item clickable to="/circles">
        <q-item-section avatar>
          <q-icon name="mdi-dashboard" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t("circles.dashboard.label") }}</q-item-label>
          <q-item-label caption>
            {{ $t("circles.dashboard.caption") }}
          </q-item-label>
        </q-item-section>
      </q-item>
      <q-item clickable to="/circles/diagram">
        <q-item-section avatar>
          <q-icon name="mdi-diagram" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t("circles.diagram.label") }}</q-item-label>
          <q-item-label caption>
            {{ $t("circles.diagram.caption") }}
          </q-item-label>
        </q-item-section>
      </q-item>
      <!-- <q-item clickable to="/circles/visualization">
        <q-item-section avatar>
          <q-icon name="mdi-diagram" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t("circles.diagram2.label") }}</q-item-label>
          <q-item-label caption>
            {{ $t("circles.diagram2.caption") }}
          </q-item-label>
        </q-item-section>
      </q-item> -->
      <q-item clickable to="/circles/org-chart">
        <q-item-section avatar>
          <q-icon name="mdi-chart" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t("circles.orgChart.label") }}</q-item-label>
          <q-item-label caption>
            {{ $t("circles.orgChart.caption") }}
          </q-item-label>
        </q-item-section>
      </q-item>
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
};
const toggleD3ForcedDialog = () => {
  d3ForcedVisible.value = !d3ForcedVisible.value;
};
</script>

<style lang="scss">
</style>
