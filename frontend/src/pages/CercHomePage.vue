<template>
  <q-page>
    <div class="text-h3 text-center justify-center row full-width q-pb-sm text-primary text-bold">
      {{ $t("cerc.dashboard.title", 'Cerc') }}
    </div>
    <div class="text-h4 text-italic text-center justify-center row full-width q-pb-lg text-primary text-bold">
      {{ $t("cerc.dashboard.subtitle", 'Organize your org') }}
    </div>

    <div class="row full-width">

      <div :class="$q.screen.lt.md ? ' col-12 q-px-md q-pb-md' : ' col-5 q-pl-xl q-pr-lg'">
        <q-card>
          <q-card-section class="bg-blue-5">
            <div class="full-width text-center text-h5 text-bold">Cerc - Domain Circles</div>
          </q-card-section>

          <q-card-section>
            <div class="full-width text-center text-h2 text-italic text-bold q-pt-lg">Get Started</div>
          </q-card-section>

          <div v-if="workspace.fsaApiEnabled" class="q-pb-lg">
            <q-card-actions class="justify-center">
              <q-btn @click="workspace.createWorkspace()" label="Create Workspace" color="orange-10" size="xl"></q-btn>
            </q-card-actions>
            <q-card-actions v-if="workspace.hasWorkspaces" class="justify-center q-pb-xl">
              <q-btn @click="workspace.openWorkspace()" flat label="Open Workspace" color="primary" size="xl"></q-btn>
            </q-card-actions>
          </div>
          <div v-else>
            <q-card-actions class="justify-center q-pb-lg">
              <p class="q-px-xl text-negative">Your browser does not support the Filesystem API. You must use a recent
                Chrome desktop browser, or other compatible browser.</p>
            </q-card-actions>
          </div>

          <q-separator></q-separator>

          <q-card-section>
            <div class="full-width text-center text-h5 text-bold q-pt-lg">Your Free Benefits</div>

            <p class="text-body1 q-mx-lg q-mt-md">
            <ul>
              <li class="q-py-sm text-bold">Your data never leaves your computer, we never see it.</li>
              <li class="q-py-sm text-bold">You can create an unlimited number of workspaces and organizations.</li>
            </ul>
            </p>
            <div class="full-width text-center text-h5 text-bold q-pt-lg">How Does It Work?</div>
            <p class="text-body1 q-mx-lg q-mt-md">
            <ul>
              <li class="q-py-sm">Data is stored in a local workspace directory.</li>
              <li class="q-py-sm">New or existing directories can be workspace enabled.</li>
              <li class="q-py-sm">Multiple apps can access the same workspace.</li>
            </ul>
            </p>
          </q-card-section>

        </q-card>
      </div>


      <div :class="$q.screen.lt.md ? ' col-12 q-px-md q-pb-md' : ' col-7 q-pr-xl q-pl-lg'">
        <q-card>
          <q-card-section class="bg-blue-5">
            <div class="full-width text-center text-h5 text-bold">Additional Info</div>
          </q-card-section>
          <q-card-section class="q-pt-none word-wrap">
            <MdPreview v-model="cercInfo" language="en-US" />
          </q-card-section>
        </q-card>
      </div>

    </div>

  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { useQuasar } from "quasar";

import { MdPreview } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';

import { useWorkspaceStore } from "../stores/workspace";
import { useCercStore } from "../stores/cerc";

const workspace = useWorkspaceStore();
const cerc = useCercStore();

// Info page content stored in Markdown and fetched on first load.
const cercInfo = ref('');

const $q = useQuasar();

if (cercInfo.value.length < 1) {
  fetch("/md/cerc-info.md")
    .then((response) => {
      return response.text();
    })
    .then((responseBody) => {
      cercInfo.value = responseBody
    });
}


</script>

<style lang="scss">

</style>
