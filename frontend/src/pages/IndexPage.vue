<template>
  <q-page class="row items-center justify-evenly">
    <div
      class="text-h2 full-width text-center text-bold navbar-brand-link q-ma-md"
    >
      {{ $t("homepage.heading1") }}
      <br />
      <span class="text-h1 text-bold">{{ $t("homepage.heading2") }}</span>
    </div>

    <div class="row fit justify-center">
      <div class="col-9 q-ma-lg">
        <q-carousel
          swipeable
          animated
          v-model="slide"
          thumbnails
          infinite
          height="600px"
          :autoplay="autoplay"
          transition-prev="slide-right"
          transition-next="slide-left"
          @mouseenter="autoplay = false"
          @mouseleave="autoplay = true"
        >
          <q-carousel-slide
            name="first"
            img-src="https://platform.ultri.com/imgs/canava/canava-light.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div class="text-h1 text-bold text-center">
                Intoducing CANAVA!
              </div>
              <div class="text-h2 text-center text-bold">
                A better canvas builder
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="second"
            img-src="https://platform.ultri.com/imgs/canava/canava-dark.png"
          >
            <div class="absolute-center custom-caption text-white">
              <div class="text-h1 text-bold text-center">DARK MODE</div>
              <div class="text-h2 text-center text-bold">SUPPORTED</div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="third"
            img-src="https://platform.ultri.com/imgs/canava/canava-canvas-template-options.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div class="text-h1 text-bold text-center">Use a template</div>
              <div class="text-h2 text-center text-bold">
                or start from scratch
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="fourth"
            img-src="https://platform.ultri.com/imgs/canava/canava-creator-dialog.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div class="text-h1 text-bold text-center">Configure canvas</div>
              <div class="text-h2 text-center text-bold">sections easily</div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="fifth"
            img-src="https://platform.ultri.com/imgs/canava/canava-view-canvas-button.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div class="text-h1 text-bold text-center">View Canvas</div>
              <div class="text-h2 text-center text-bold">
                by clicking on the eye button
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="sixth"
            img-src="https://platform.ultri.com/imgs/canava/canava-canvas-interaction-view.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div class="text-h1 text-bold text-center">Canvas interface</div>
              <div class="text-h2 text-center text-bold">
                allows managing the canvas items
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="seventh"
            img-src="https://platform.ultri.com/imgs/canava/canava-item-editor.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div class="text-h1 text-bold text-center">Manage items</div>
              <div class="text-h2 text-center text-bold">
                in each section individually
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="eighth"
            img-src="https://platform.ultri.com/imgs/canava/canava-configure-link.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div class="text-h1 text-bold text-center">Configure canvas</div>
              <div class="text-h2 text-center text-bold">
                by clicking on the cog button
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="ninth"
            img-src="https://platform.ultri.com/imgs/canava/canava-colored-sections.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div class="text-h1 text-bold text-center">Custom colors</div>
              <div class="text-h2 text-center text-bold">
                for background and text
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="tenth"
            img-src="https://platform.ultri.com/imgs/canava/canava-turn-off-instructions.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div class="text-h1 text-bold text-center">Hide elements</div>
              <div class="text-h2 text-center text-bold">
                to reduce noise on screen
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="eleventh"
            img-src="https://platform.ultri.com/imgs/canava/canava-delete-link.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div class="text-h1 text-bold text-center">Start fresh</div>
              <div class="text-h2 text-center text-bold">
                by deleting any canvas data
              </div>
            </div>
          </q-carousel-slide>
        </q-carousel>
      </div>
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
import { ref } from "vue";
import { useQuasar } from "quasar";
import { useAuthStore } from "../stores/auth";
import { useColorStore } from "../stores/color";
const auth = useAuthStore();
const colorStore = useColorStore();

const $q = useQuasar();

const slide = ref("first");

const triggerSignInDialog = async () => {
  auth.setTargetUrl("/member");
  auth.setSignInRequired(true);
  console.log(auth.targetUrl);
};
</script>
