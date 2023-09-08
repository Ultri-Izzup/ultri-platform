<template>
    <q-page class="row">
    <div
      class="text-h2 full-width text-center text-bold navbar-brand-link q-ma-md"
    >
      {{ $t("legal.title", "Legal Documents") }}
    </div>
    <div class="row full-width justify-center">
      <q-tabs
      v-model="tab"
      dense
      class="text-grey q-pb-lg"
      active-color="primary"
      indicator-color="primary"
      align="justify"
      narrow-indicator
    >
      <q-tab name="privacy" label="Privacy Policy"></q-tab>
      <q-tab name="tos" label="Terms of Service"></q-tab>
      <q-tab name="dataRights" label="Data Rights"></q-tab>
      <q-tab name="eula" label="EULA"></q-tab>
    </q-tabs>

    </div>



    <q-tab-panels v-model="tab" animated>
      <q-tab-panel name="privacy">
        <ultri-privacy-policy />
      </q-tab-panel>
      <q-tab-panel name="tos">
        <u-md-view v-model="privacyPolicy" />
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
import UltriPrivacyPolicy from "../components/ultri/UltriPrivacyPolicy.vue"
import UltriServices from "../components/ultri/UltriServices.vue"

import UMdView from "../components/ultri/UMdView.vue"

const auth = useAuthStore();
const colorStore = useColorStore();
const canavaStore = useCanavaStore();
const router = useRouter();
const route = useRoute();

const selectedCanvas = ref(null);
const selectedSavedCanvas = ref(null);

const tab = ref("privacy-policy");



onMounted(async () => {
  canavaStore.loadMemberCanvas();
});


</script>

