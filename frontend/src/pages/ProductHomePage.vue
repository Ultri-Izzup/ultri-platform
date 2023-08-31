<template>
<q-page class="row justify-evenly">
  <div
    class="text-h2 full-width text-center text-bold navbar-brand-link q-ma-md"
  >
    {{ $t("products.heading1", "Ultri Products") }}
    <br />
    <!-- <span class="text-h3 text-bold">{{
      $t("products.heading2", "Coming soon...")
    }}</span> -->
  </div>

  <div class="row full-width">
    <div :class="Screen.lt.md ? 'col-12' : 'col-6'">
      <q-card>
        <q-card-section>
          Ultri Organizations
        </q-card-section>
      </q-card>
    </div>
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
