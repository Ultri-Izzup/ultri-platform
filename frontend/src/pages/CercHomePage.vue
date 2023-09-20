<template>
  <q-page>
    <div class="text-center justify-center row full-width q-pb-lg text-primary text-bold items-center">
      <span class="text-h2 text-bold">{{ $t("cerc.dashboard.title", 'Cerc') }}</span><span class="q-pl-md gt-sm text-h3 text-italic">&mdash; {{ $t("cerc.dashboard.subtitle", 'Organize your org') }}</span>
    </div>
    <div class="row full-width">

      <div :class="$q.screen.lt.md ? ' col-12 q-px-md q-pb-md' : ' col-5 q-pl-xl q-pr-lg'">
        <q-card class="u-card">
          <q-card-section class="u-card-toolbar">
            <div class="full-width text-center text-h5 text-bold">Cerc - Domain Circles</div>
          </q-card-section>

          <q-card-section>
            <div class="full-width text-center text-h2 text-italic text-bold q-pt-lg">Get Started</div>
          </q-card-section>

          <div v-if="workspace.fsaApiEnabled" class="q-pb-lg">
            <q-card-actions class="justify-center">
              <q-btn @click="triggerWorkspaceDialog()" label="Create Workspace" class="u-btn-cta" size="xl"></q-btn>
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
              <li class="q-py-sm">Integrated canvases, using <a href="/canava">Canava technology</a>.</li>
            </ul>
            </p>
          </q-card-section>

        </q-card>
      </div>

      <div :class="$q.screen.lt.md ? ' col-12 q-px-md q-pb-md' : ' col-7 q-pr-xl q-pl-lg '">
        <q-card class="u-card">
          <q-card-section class="u-card-toolbar">
            <div class="full-width text-center text-h5 text-bold">Additional Info</div>
          </q-card-section>
          <q-card-section class="q-pt-none word-wrap">
            <MdPreview v-model="cercInfo" language="en-US" />
          </q-card-section>
        </q-card>
      </div>

      <UDialogPrompt
        v-model="showWorkspaceDialog"
        toolbar-text="Create Workspace"
        headline-text="Workspace Alias"
        instructions-text="Enter a name or alias to use, then choose the directory."
        label-text="32 characters or less, no special characters"
        button-text="Choose Directory"
        :validator="(str) => { return ! (str && /^[A-Za-z0-9_-]{1,32}$/.test(str)); }"
        @ok="(event) => workspace.createWorkspace(event)"
      ></UDialogPrompt>

    </div>

  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { useQuasar } from "quasar";

import { MdPreview } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';

import { useWorkspaceStore } from "../stores/workspace";
import { useAuthStore } from "../stores/auth";
import { useCercStore } from "../stores/cerc";

import UDialogPrompt from "../components/ultri/dialog/UDialogPrompt.vue";

// Quasar
const $q = useQuasar();

// Stores
const workspace = useWorkspaceStore();
const auth = useAuthStore();
const cerc = useCercStore();

// Alias for a new or current Workspace
const workspaceAlias = ref();

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

// Disaply dialog to collect info for a new workspace
const triggerWorkspaceDialog = async () => {
  // Display a dialog to collect the workspace name
  showWorkspaceDialog.value = true;
}

const getWorkspaceOrgs = async () => {
  // Display a dialog to collect the Org name

  // Create Org and forward

}

const createOrg = async () => {
  // Display a dialog to collect the Org name

  // Create Org and forward

}

// const showWorkspaceDialog = async () => {

//   workspace.authCheck();

//   $q.dialog({
//     title: 'Workspace alias',
//     message: 'Enter an alias for the workspace',
//     prompt: {
//       model: '',
//       type: 'text', // optional
//       label: 'Less than 32 characters, no spaces or special characters allowed.'
//     },
//     cancel: true,
//     persistent: true
//   }).onOk(async data => {
//      console.log('>>>> OK, received', data)
//      await workspace.createWorkspace(data)
//   }).onCancel(() => {
//      console.log('>>>> Cancel')
//   }).onDismiss(() => {
//      console.log('I am triggered on both OK and Cancel')
//   })

// }

</script>

<style lang="scss">

</style>
