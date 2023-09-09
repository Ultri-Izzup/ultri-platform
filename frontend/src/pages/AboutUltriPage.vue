<template>
  <q-page class="row items-center justify-evenly">
    <div
      class="text-h2 full-width text-center text-bold navbar-brand-link q-ma-md"
    >
      {{ $t("about.title") }}
    </div>
    <div class="gt-md text-h6 full-width text-center text-bold q-pt-sm q-pb-lg">
      Created by and for, open source developers.
    </div>

    <q-tabs
      v-model="tab"
      dense
      class="text-grey q-pb-lg"
      active-color="primary"
      indicator-color="primary"
      align="justify"
      narrow-indicator
    >
      <q-tab name="timeline" label="Timeline"></q-tab>
      <q-tab name="services" label="Services"></q-tab>
      <!-- <q-tab name="products" label="Products"></q-tab>
      <q-tab name="projects" label="Projects"></q-tab> -->
    </q-tabs>

    <q-tab-panels v-model="tab" animated>
      <q-tab-panel name="timeline">
        <ultri-timeline />
      </q-tab-panel>
      <q-tab-panel name="services">
        <ultri-services />
      </q-tab-panel>
      <q-tab-panel>

      </q-tab-panel>
    </q-tab-panels>
  </q-page>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import { useRouter, useRoute } from "vue-router";

import { useAuthStore } from "../stores/auth";
import { useColorStore } from "../stores/color";
import { useCanavaStore } from "../stores/canava";
import UltriTimeline from "../components/ultri/UltriTimeline.vue"
import UltriServices from "../components/ultri/UltriServices.vue"

const auth = useAuthStore();
const colorStore = useColorStore();
const canavaStore = useCanavaStore();
const router = useRouter();
const route = useRoute();

const selectedCanvas = ref(null);
const selectedSavedCanvas = ref(null);

const tab = ref("timeline");

onMounted(async () => {
  canavaStore.loadMemberCanvas();
});


</script>
