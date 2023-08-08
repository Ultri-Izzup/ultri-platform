<template>
  <div>
    <q-drawer v-model="leftDrawerOpen" show-if-above bordered>
      <HomepageDrawer v-if="route.meta.drawer == 'Homepage'"></HomepageDrawer>
      <DefaultDrawer v-if="route.meta.drawer == 'Default'"></DefaultDrawer>
      <LogbookDrawer v-if="route.meta.drawer == 'Logbook'"></LogbookDrawer>
      <CanvasDrawer v-if="route.meta.drawer == 'Canvas'"></CanvasDrawer>
      <DashboardDrawer
        v-if="route.meta.drawer == 'Dashboard'"
      ></DashboardDrawer>
      <OrgDrawer v-if="route.meta.drawer == 'Org'"></OrgDrawer>
      <CirclesDrawer v-if="route.meta.drawer == 'Circle'"></CirclesDrawer>
    </q-drawer>
  </div>
</template>

<script setup>
import { useRoute } from "vue-router";

import LogbookDrawer from "../../layouts/drawers/LogbookDrawer.vue";
import DefaultDrawer from "../../layouts/drawers/DefaultDrawer.vue";
import HomepageDrawer from "../../layouts/drawers/HomepageDrawer.vue";
import CanvasDrawer from "../../layouts/drawers/CanvasDrawer.vue";
import DashboardDrawer from "../../layouts/drawers/DashboardDrawer.vue";
import OrgDrawer from "../../layouts/drawers/OrgDrawer.vue";
import CirclesDrawer from "../../layouts/drawers/CirclesDrawer.vue";

const route = useRoute();

const props = defineProps({
  leftDrawOpen: {
    type: Boolean,
    defualt: false
  }
})

// Stores
</script>

<style lang="scss">
</style>
