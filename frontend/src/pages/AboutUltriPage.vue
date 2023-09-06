<template>
  <q-page class="row items-center justify-evenly">
    <div
      class="text-h2 full-width text-center text-bold navbar-brand-link q-ma-md"
    >
      {{ $t("about.title") }}
    </div>
    <div class="row" :style="Screen.lt.md ? 'width: 100%' : 'width: 80%'">

    </div>
  </q-page>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { useQuasar } from "quasar";
import { useAuthStore } from "../stores/auth";
import { useColorStore } from "../stores/color";
import { useCanavaStore } from "../stores/canava";
import { Screen } from "quasar";

const auth = useAuthStore();
const colorStore = useColorStore();
const canavaStore = useCanavaStore();
const router = useRouter();

const selectedCanvas = ref(null);
const selectedSavedCanvas = ref(null);

onMounted(async () => {
  canavaStore.loadMemberCanvas();
})

const loadCanvasTemplate = () => {
  console.log(selectedCanvas.value)
  router.push({ name: 'canavaTemplate', params: {canvasTemplate: selectedCanvas.value.value }})
}

const loadSavedCanvas = () => {
  console.log(selectedSavedCanvas.value)
  router.push({ name: 'canavaTemplate', params: {canvasTemplate: selectedSavedCanvas.value.value }})
}

const autoplay = ref(true);

const $q = useQuasar();

const slide = ref("first");

</script>
