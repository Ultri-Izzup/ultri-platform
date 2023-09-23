<template>
  <q-page>
    <div class="text-center justify-center row full-width q-pb-lg text-primary text-bold items-center">
      <span class="text-h2 text-bold">{{
          $t("fediverse.homepage.title", "Ultri + Izzup")
      }}</span><span class="q-pl-md gt-sm text-h3 text-italic">&mdash; {{ tagline }}</span>
    </div>
    <div class="row full-width">
      <q-card class="full-width">
        <q-tabs v-model="tab" dense class="text-grey" active-color="primary" indicator-color="primary" align="justify"
          narrow-indicator>
          <q-tab name="accounts" label="Accounts"></q-tab>
          <q-tab name="tech" label="Technical"></q-tab>
        </q-tabs>

        <q-separator></q-separator>
        <q-tab-panels v-model="tab" animated>
          <q-tab-panel name="accounts">
            <MdPreview v-model="accountsMd" language="en-US" />
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

const tab = ref('accounts');

const accountsMd = ref('');
const techDetailsMd = ref('');


const tagline = ref('a new Fediverse')


  // If ref is empty, fetch Markdown and store in ref
  if (techDetailsMd.value.length < 1) {
    fetch("/md/fediverse/ultri-izzup-connectivity.md")
    .then((response) => {
      return response.text();
    })
    .then((responseBody) => {
      techDetailsMd.value = responseBody
    });
  }

  if (accountsMd.value.length < 1) {
    fetch("/md/fediverse/ultri-izzup-fediverse-accounts.md")
    .then((response) => {
      return response.text();
    })
    .then((responseBody) => {
      accountsMd.value = responseBody
    });
  }


  watch((tab), (oldVal, newVal) => {
    tagline.value = getRandTagline();
  })



const taglines = [
  'A better Fediverse',
  'The Ultriverse',
  'Community with a voice',
  'A better way to share',
  'Cutout the corporate'
]

const getRandTagline = () => {
  const index = Math.floor(Math.random() * (taglines.length))
  const randomElement = taglines[index];
  return randomElement;
}
</script>

<style lang="scss">

</style>
