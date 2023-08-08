<template>
  <q-page class="row items-center justify-evenly">
    <div
      class="text-h3 full-width text-center text-bold navbar-brand-link q-ma-lg"
    >
      {{ $t("homepage.heading1") }}
      <br />
      {{ $t("homepage.heading2") }}
      <br />
      {{ $t("homepage.heading3") }}
    </div>

    <div class="row fit justify-center">
      <div class="col-9 q-ma-lg">
        <q-card class="full-width" flat>
          <q-card-section class="q-pa-md">
            <a href="/canvas/business">
              <q-img
                :src="
                  colorStore.darkMode
                    ? 'https://platform.ultri.com/imgs/canvas/business-model-canvas-dark.png'
                    : 'https://platform.ultri.com/imgs/canvas/business-model-canvas-light.png'
                "
                class="q-pa-md"
              >
                <div class="absolute-full flex flex-center text-center gt-xs text-h3">
                  A Better Business Model Canvas
                </div>
                <div class="absolute-full flex flex-center text-center lt-sm">
                  Business Model Canvas
                </div>
              </q-img>
            </a>
          </q-card-section>
        </q-card>
      </div>
    </div>

    <div
      class="text-h2 full-width text-center text-bold navbar-text-link q-ma-lg"
    >
      {{ $t("homepage.tagline") }}
    </div>
    <div class="full-width text-center">
      <q-btn
        size="xl"
        :label="$t('homepage.button')"
        color="primary"
        href="https://discord.gg/jaJ3v6Zx"
        rounded
      ></q-btn>
    </div>
  </q-page>
</template>

<script setup>
import { useQuasar } from "quasar";
import { useAuthStore } from "../stores/auth";
import { useColorStore } from "../stores/color";
const auth = useAuthStore();
const colorStore = useColorStore();

const $q = useQuasar();


const triggerSignInDialog = async () => {
  auth.setTargetUrl("/member");
  auth.setSignInRequired(true);
  console.log(auth.targetUrl);
};
</script>
