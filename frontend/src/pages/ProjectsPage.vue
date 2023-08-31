<template>
  <q-page class="row items-center justify-evenly">
    <div
      class="text-h2 full-width text-center text-bold navbar-brand-link q-ma-md"
    >
      {{ $t("projects.heading1", "Ultri Projects") }}
      <br />
      <span class="text-h1 text-bold">{{ $t("homepage.heading2", "Open source solutions") }}</span>
    </div>

  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { useQuasar } from "quasar";
import { useAuthStore } from "../stores/auth";
import { useColorStore } from "../stores/color";
import { Screen } from "quasar";

const auth = useAuthStore();
const colorStore = useColorStore();

const autoplay = ref(true);

const $q = useQuasar();

const slide = ref("first");

const triggerSignInDialog = async () => {
  auth.setTargetUrl("/member");
  auth.setSignInRequired(true);
  console.log(auth.targetUrl);
};
</script>
