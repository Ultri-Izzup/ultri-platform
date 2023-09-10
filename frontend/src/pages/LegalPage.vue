<template>
  <div class="row">

    <div v-if="!currentPolicy" class="text-h2 text-center full-width text-bold text-primary q-pb-lg">
     Legal Policies
    </div>


    <div class="text-h6 text-center full-width">
      <q-tabs>
        <q-route-tab label="Privacy" to="/legal/privacy" exact />
        <q-route-tab label="Cookies" to="/legal/cookies" exact />
      </q-tabs>
    </div>
    <div
      v-if="currentPolicy && policyData.length > 0"
      class="row full-width justify-center q-px-xl q-pt-md"
    >
      <u-md-view v-model="policyData" />
    </div>
    <div
      v-if="!currentPolicy"
      class="q-pt-sm row full-width justify-center q-px-xl"
    >
    <p class="text-body1 text-bold justify-center " >View policies using the links above</p>
    </div>
    <div v-if="!currentPolicy" class="q-pt-sm row full-width justify-center q-px-sm">
      <ul>
        <li class="q-py-sm">All policies are subject to change.</li>
        <li>The latest policies will always be posted here.</li>
      </ul>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, watch } from "vue";
import { useRouter, useRoute } from "vue-router";

import { useAuthStore } from "../stores/auth";
import { useColorStore } from "../stores/color";

import UltriPrivacyPolicy from "../components/ultri/UltriPrivacyPolicy.vue";
import UltriServices from "../components/ultri/UltriServices.vue";

import UMdView from "../components/ultri/UMdView.vue";

const auth = useAuthStore();
const colorStore = useColorStore();
const router = useRouter();
const route = useRoute();

const policyData = ref("");
const mdData = ref({
  privacy: "",
  cookies: "",
});

const currentPolicy = computed(() => route.params.policy);

watch(
  currentPolicy,
  (newValue, oldValue) => {
    switch (newValue) {
      case "cookies":
        if (mdData.value[newValue].length < 1) {
          fetch("/md/cookie-policy.md")
            .then((response) => {
              return response.text();
            })
            .then((responseBody) => {
              mdData.value[newValue] = responseBody;
              policyData.value = responseBody;
            });
        } else {
          policyData.value = mdData.value[newValue];
        }
        break;
      case "privacy":
        if (mdData.value[newValue].length < 1) {
          fetch("/md/privacy-policy.md")
            .then((response) => {
              return response.text();
            })
            .then((responseBody) => {
              mdData.value[newValue] = responseBody;
              policyData.value = responseBody;
            });
        } else {
          policyData.value = mdData.value[newValue];
        }
        break;
    }

  },
  { immediate: true }
);

</script>

<style lang="scss" scoped></style>
