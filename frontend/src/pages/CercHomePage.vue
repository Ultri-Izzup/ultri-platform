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
        <q-card class="u-card">
          <q-card-section class="u-card-titlebar">
            <div class="full-width text-center text-h5 text-bold">Cerc - Domain Circles</div>
          </q-card-section>

          <q-card-section>
            <div class="full-width text-center text-h2 text-italic text-bold q-pt-lg">Get Started</div>
          </q-card-section>

          <div v-if="workspace.fsaApiEnabled" class="q-pb-lg">
            <q-card-actions class="justify-center">
              <q-btn @click="createWorkspace()" label="Create Workspace" class="u-btn-cta" size="xl"></q-btn>
            </q-card-actions>
            <q-card-actions v-if="workspace.hasWorkspaces" class="justify-center q-pb-xl">
              <q-btn @click="workspace.openWorkspace()" flat label="Open Workspace" size="xl" class="u-btn-cta"></q-btn>
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
        <q-card class="u-card">
          <q-card-section class="u-card-titlebar">
            <div class="full-width text-center text-h5 text-bold">Additional Info</div>
          </q-card-section>
          <q-card-section class="q-pt-none word-wrap">
            <MdPreview v-model="cercInfo" language="en-US" />
          </q-card-section>
        </q-card>
      </div>

    </div>

    <q-dialog v-model="workspace.showNameDialog">
      <q-card>
        <q-card-section>
          <div class="text-h6">Alert</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum repellendus sit voluptate voluptas eveniet porro. Rerum blanditiis perferendis totam, ea at omnis vel numquam exercitationem aut, natus minima, porro labore.
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="OK" color="primary" v-close-popup></q-btn>
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog v-model="showWorkspaceDialog" persistent>
      <q-card>
        <q-card-section class="row items-center">
          <q-avatar icon="signal_wifi_off" color="primary" text-color="white"></q-avatar>
          <span class="q-ml-sm">You are currently not connected to any network.</span>
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Cancel" color="primary" v-close-popup></q-btn>
          <q-btn flat label="Turn on Wifi" color="primary" v-close-popup></q-btn>
        </q-card-actions>
      </q-card>
    </q-dialog>

  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { useQuasar } from "quasar";

import { MdPreview } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';

import { useWorkspaceStore } from "../stores/workspace";
import { useCercStore } from "../stores/cerc";

// Quasar
const $q = useQuasar();

// Stores
const workspace = useWorkspaceStore();
const cerc = useCercStore();

// Display new workspace dialog?
const showWorkspaceDialog = ref(false);

// Page content markdown, fetched on first load.
const cercInfo = ref('');
// If ref is empty, fetch Markdown and store in ref
if (cercInfo.value.length < 1) {
  fetch("/md/cerc-info.md")
    .then((response) => {
      return response.text();
    })
    .then((responseBody) => {
      cercInfo.value = responseBody
    });
}

// Create a new workspace
const createWorkspace = async () => {
  // Display a dialog to collect the workspace name
  showNameDialog.value = true;

  // Start the process to select a directory using the store

  // Failure? - Show error dialog, try again or cancel?

  // Success?

  // Register Cerc app in workspace


}

const getWorkspaceOrgs = async () => {
  // Display a dialog to collect the Org name

  // Create Org and forward

}

const createOrg = async () => {
  // Display a dialog to collect the Org name

  // Create Org and forward

}


</script>

<style lang="scss">

</style>
