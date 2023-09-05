<template>
  <q-page class="row items-center justify-evenly">
    <div
      class="text-h2 full-width text-center text-bold navbar-brand-link q-ma-md"
    >
      {{ $t("canava.home.heading") }}
    </div>
    <div class="row" :style="Screen.lt.md ? 'width: 100%' : 'width: 80%'">
      <div :class="Screen.lt.md ? 'col-12 q-pa-sm' : 'col-6 q-pa-lg'">
        <q-card class="q-pa-sm fit">
          <q-card-section>
            <div class="text-h4 text-bold text-primary q-pb-sm">
              {{ $t("canava.home.getStarted") }}
            </div>
            <q-separator></q-separator>
            <div v-if="canavaStore.openTemplateOpts.length > 0 || canavaStore.savedCanvasOpts.length > 0">
            <p class="text-h5 text-bold q-px-md q-pt-lg text-primary">
              Your canvases
            </p>
            <p class="row text-center justify-center">
              <q-select
                filled
                label="Open Canvases"
                v-model="selectedSavedCanvas"
                :options="canavaStore.openTemplateOpts"
                @update:model-value="loadSavedCanvas()"
                style="width: 80%"
                class="text-center"
              ><q-tooltip>The canvas you have open in this session</q-tooltip></q-select>
            </p>
            <p class="row text-center justify-center">
              <q-select
                filled
                label="Saved Canvases"
                v-model="selectedSavedCanvas"
                :options="canavaStore.savedCanvasOpts"
                @update:model-value="loadSavedCanvas()"
                style="width: 80%"
                class="text-center"
                :disable="!auth.isSignedIn"
              ><q-tooltip> {{ auth.isSignedIn ? 'Saved in the cloud' : 'You must sign in to view saved canvas' }} </q-tooltip></q-select>
            </p>
          </div>
            <p class="text-h5 text-bold q-px-md q-pt-lg text-primary">
              Popular Canvas Templates
            </p>
            <p class="text-h6 text-shd-p-90 q-px-lg">
              We have over ten popular canvases with more coming weekly. Choose
              a template below to get started.
            </p>
            <p class="row text-center justify-center">
              <q-select
                filled
                label="Canvas Template"
                v-model="selectedCanvas"
                :options="canavaStore.canvasOpts"
                @update:model-value="loadCanvasTemplate()"
                style="width: 80%"
                class="text-center"
              ></q-select>
            </p>
            <p class="text-h5 text-bold q-px-md q-pt-lg text-primary">
              Custom Canvas Designer
            </p>
            <p class="text-h6 text-shd-p-90 q-px-lg">
              Create a custom canvas using one of our many templates, or start
              from scratch.
            </p>
            <p class="text-center">
              <q-btn
                label="Custom Canvas"
                color="primary"
                clickable
                v-ripple
                :to="{ name: 'canavaDesigner' }"
              ></q-btn>
            </p>
          </q-card-section>
        </q-card>
      </div>
      <div :class="Screen.lt.md ? 'col-12 q-pa-sm' : 'col-6 q-pa-lg'">
        <q-card class="q-pa-sm fit">
          <q-card-section>
            <div class="text-h4 text-bold text-primary q-pb-sm">
              {{ $t("canava.home.benefits", "Free Canava Benefits") }}
            </div>
            <q-separator></q-separator>
            <div :class="Screen.lt.md ? 'q-pt-sm' : 'q-pt-xl q-pl-xl'">
            <ul class="text-h6 text-shd-p-90">
              <li class="q-ma-xs" >Unlimited free canvases</li>
              <li class="q-ma-sm" >Export and import data</li>
              <li class="q-ma-sm" >Create custom canvases</li>
              <li class="q-ma-sm" >Multiple open canvases</li>
              <li class="q-ma-sm" >Access to all canvas templates</li>
              <li class="q-ma-sm" >PNG image export, more coming</li>
              <li class="q-ma-sm" >Multiple fonts provided</li>
              <li class="q-ma-sm" >Runs on desktop or mobile</li>
              <li class="q-ma-sm" >10+ free canvas templates</li>
              <li class="q-ma-sm" >New canvases added weekly</li>
              <li class="q-ma-sm" >Localization support</li>
              <li class="q-ma-sm" >Free and open source code</li>
              <li class="q-ma-sm" >Easily self-hosted</li>
            </ul>
          </div>
          </q-card-section>
        </q-card>
      </div>
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
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h2 text-bold text-center '
                    : ' text-h1 text-bold text-center '
                "
              >
                Intoducing CANAVA!
              </div>
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h3 text-bold text-center '
                    : ' text-h2 text-bold text-center '
                "
              >
                A better canvas builder
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="second"
            img-src="https://platform.ultri.com/imgs/canava/canava-dark.png"
          >
            <div class="absolute-center custom-caption text-white">
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h2 text-bold text-center '
                    : ' text-h1 text-bold text-center '
                "
              >
                DARK MODE
              </div>
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h3 text-bold text-center '
                    : ' text-h2 text-bold text-center '
                "
              >
                SUPPORTED
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="third"
            img-src="https://platform.ultri.com/imgs/canava/canava-canvas-template-options.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h2 text-bold text-center '
                    : ' text-h1 text-bold text-center '
                "
              >
                Use a template
              </div>
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h3 text-bold text-center '
                    : ' text-h2 text-bold text-center '
                "
              >
                or start from scratch
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="fourth"
            img-src="https://platform.ultri.com/imgs/canava/canava-creator-dialog.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h2 text-bold text-center '
                    : ' text-h1 text-bold text-center '
                "
              >
                Configure canvas
              </div>
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h3 text-bold text-center '
                    : ' text-h2 text-bold text-center '
                "
              >
                sections easily
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="fifth"
            img-src="https://platform.ultri.com/imgs/canava/canava-view-canvas-button.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h2 text-bold text-center '
                    : ' text-h1 text-bold text-center '
                "
              >
                View Canvas
              </div>
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h3 text-bold text-center '
                    : ' text-h2 text-bold text-center '
                "
              >
                by clicking on the eye button
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="sixth"
            img-src="https://platform.ultri.com/imgs/canava/canava-canvas-interaction-view.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h2 text-bold text-center '
                    : ' text-h1 text-bold text-center '
                "
              >
                Canvas interface
              </div>
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h3 text-bold text-center '
                    : ' text-h2 text-bold text-center '
                "
              >
                allows managing the canvas items
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="seventh"
            img-src="https://platform.ultri.com/imgs/canava/canava-item-editor.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h2 text-bold text-center '
                    : ' text-h1 text-bold text-center '
                "
              >
                Manage items
              </div>
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h3 text-bold text-center '
                    : ' text-h2 text-bold text-center '
                "
              >
                in each section individually
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="eighth"
            img-src="https://platform.ultri.com/imgs/canava/canava-configure-link.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h2 text-bold text-center '
                    : ' text-h1 text-bold text-center '
                "
              >
                Configure canvas
              </div>
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h3 text-bold text-center '
                    : ' text-h2 text-bold text-center '
                "
              >
                by clicking on the cog button
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="ninth"
            img-src="https://platform.ultri.com/imgs/canava/canava-colored-sections.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h2 text-bold text-center '
                    : ' text-h1 text-bold text-center '
                "
              >
                Custom colors
              </div>
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h3 text-bold text-center '
                    : ' text-h2 text-bold text-center '
                "
              >
                for background and text
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="tenth"
            img-src="https://platform.ultri.com/imgs/canava/canava-turn-off-instructions.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h2 text-bold text-center '
                    : ' text-h1 text-bold text-center '
                "
              >
                Hide elements
              </div>
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h3 text-bold text-center '
                    : ' text-h2 text-bold text-center '
                "
              >
                to reduce noise on screen
              </div>
            </div>
          </q-carousel-slide>
          <q-carousel-slide
            name="eleventh"
            img-src="https://platform.ultri.com/imgs/canava/canava-delete-link.png"
          >
            <div class="absolute-center custom-caption text-blue-10">
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h2 text-bold text-center '
                    : ' text-h1 text-bold text-center '
                "
              >
                Start fresh
              </div>
              <div
                :class="
                  Screen.lt.md
                    ? ' text-h3 text-bold text-center '
                    : ' text-h2 text-bold text-center '
                "
              >
                by deleting any canvas data
              </div>
            </div>
          </q-carousel-slide>
        </q-carousel>
      </div>
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
  console.log(`the component is now mounted.`)
  const storedCanvases = await canavaStore.loadMemberCanvas();
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
