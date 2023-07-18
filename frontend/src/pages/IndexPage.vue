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
      <br />
      {{ $t("homepage.heading4") }}
    </div>

    <div class="row fit justify-center">
      <div class="col-9 q-ma-lg">
        <q-card class="full-width">
          <q-card-section class="q-pa-md">
            <a href="https://handbook.opensociocracy.org/">
              <q-img
                :src="
                  color.darkMode
                    ? 'https://handbook.opensociocracy.org/ultri/handbook-screenshot-dk.png'
                    : 'https://handbook.opensociocracy.org/ultri/handbook-screenshot-lt.png'
                "
                class="q-pa-md"
              >
                <div class="absolute-top text-center gt-xs text-h3">
                  Our first product: OpenSociocracy
                </div>
                <div class="absolute-bottom text-center lt-sm">
                  Our first product: OpenSociocracy
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
        href="https://discord.gg/GE8NqcJx"
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
const color = useColorStore();

const triggerSignInDialog = async () => {
  auth.setTargetUrl("/member");
  auth.setSignInRequired(true);
  console.log(auth.targetUrl);
};
</script>
