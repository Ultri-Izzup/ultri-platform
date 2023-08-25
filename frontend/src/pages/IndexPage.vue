<template>
  <q-page class="row items-center justify-evenly">
    <div
      class="text-h3 full-width text-center text-bold navbar-text-link q-ma-lg"
    >
      {{ $t("homepage.heading1") }}
      <br />
      <span class="text-h1 text-bold ">{{ $t("homepage.heading2") }}</span>
      </div>
      <div
      class="text-h3 full-width text-center text-bold navbar-brand-link"
    >
      {{ $t("homepage.heading3") }}
      <br />
      {{ $t("homepage.heading4") }}
      <br />
      <span class="text-italic text-strike">{{ $t("homepage.preview") }}</span><br /><span class="text-italic text-bolder">{{ $t("homepage.released") }}</span>
    </div>

    <div class="row fit justify-center">
      <div class="col-9 q-ma-lg">
        <q-card class="full-width" flat>
          <q-card-section class="q-pa-md">
            <a href="/canava">
              <q-img
                :src="
                  colorStore.darkMode
                    ? 'https://platform.ultri.com/imgs/canava/canava-dark.png'
                    : 'https://platform.ultri.com/imgs/canava/canava-light.png'
                "
                class="q-pa-md"
              >
                <div class="absolute-full flex flex-center text-center gt-xs text-h3">
                  A collection of customizable business canvas.
                </div>
                <div class="absolute-full flex flex-center text-center lt-sm">
                  Customizable Business Canvas
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
        href="/canava"
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
