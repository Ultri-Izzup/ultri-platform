<template>
  <q-page>
    <div class="text-center justify-center row full-width q-pb-lg text-primary text-bold items-center">
      <span class="text-h2 text-bold">{{
          $t("cerc.dashboard.title", "Workspaces")
      }}</span><span class="q-pl-md gt-sm text-h3 text-italic">&mdash; {{ tagline }}</span>
    </div>
    <div class="row full-width">
      <q-card class="full-width">
        <q-tabs v-model="tab" dense class="text-grey" active-color="primary" indicator-color="primary" align="justify"
          narrow-indicator>
          <q-tab name="business" label="Business"></q-tab>
          <q-tab name="personal" label="Personal"></q-tab>
          <q-tab name="tech" label="Details"></q-tab>
        </q-tabs>

        <q-separator></q-separator>
        <q-tab-panels v-model="tab" animated>
          <q-tab-panel name="business">
            <MdPreview v-model="businessMd" language="en-US" />
          </q-tab-panel>

          <q-tab-panel name="personal">
            <MdPreview v-model="personalMd" language="en-US" />
          </q-tab-panel>

          <q-tab-panel name="tech">
            <MdPreview v-model="techDetailsMd" language="en-US" />
          </q-tab-panel>
        </q-tab-panels>
      </q-card>
    </div>
  </q-page>
</template>

<script setup>
import { ref, watch } from "vue";
import { useQuasar } from "quasar";

import { MdPreview } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';

import { useWorkspaceStore } from "../stores/workspace";
import { useAuthStore } from "../stores/auth";

// import UDialogPrompt from "../components/ultri/dialog/UDialogPrompt.vue";

// Quasar
const $q = useQuasar();

// Stores
const workspace = useWorkspaceStore();
const auth = useAuthStore();

const tab = ref('tech');


const businessMd = ref('');
const personalMd = ref('');
const techDetailsMd = ref('');


const tagline = ref('Get it going')


  // If ref is empty, fetch Markdown and store in ref
  if (techDetailsMd.value.length < 1) {
    fetch("/md/workspace/workspace-technical-details.md")
    .then((response) => {
      return response.text();
    })
    .then((responseBody) => {
      techDetailsMd.value = responseBody
    });
  }

  if (personalMd.value.length < 1) {
    fetch("/md/workspace/workspace-personal-uses.md")
    .then((response) => {
      return response.text();
    })
    .then((responseBody) => {
      personalMd.value = responseBody
    });
  }

  if (businessMd.value.length < 1) {
    fetch("/md/workspace/workspace-business-uses.md")
    .then((response) => {
      return response.text();
    })
    .then((responseBody) => {
      businessMd.value = responseBody
    });
  }


  watch((tab), (oldVal, newVal) => {
    tagline.value = getRandTagline();
  })



const taglines = [
  'Get it together',
  'Get it easier',
  'Get it done',
  'Get it now!',
  'Get it right',
  'Get it faster',
  'Get it your way',
  'Get it started',
  'Get it launched'
]

const getRandTagline = () => {
  const index = Math.floor(Math.random() * (taglines.length))
  const randomElement = taglines[index];
  return randomElement;
}
</script>

<style lang="scss">

</style>
