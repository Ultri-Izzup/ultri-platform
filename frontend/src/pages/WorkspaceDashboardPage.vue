<template>
  <q-page>
    <div class="text-center justify-center row full-width q-pb-lg text-primary text-bold items-center">
      <span class="text-h2 text-bold">{{ $t("cerc.dashboard.title", 'Workspaces') }}</span><span class="q-pl-md gt-sm text-h3 text-italic">&mdash; {{ $t("cerc.dashboard.subtitle", 'Get it together') }}</span>
    </div>
    <div class="row full-width">


        <q-card class="u-card">
          <q-card-section class="u-card-toolbar">
            <div class="full-width text-center text-h5 text-bold">Additional Info</div>
          </q-card-section>
          <q-card-section class="q-pt-none word-wrap">
            <MdPreview v-model="cercInfo" language="en-US" />
          </q-card-section>
        </q-card>



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

import UDialogPrompt from "../components/ultri/dialog/UDialogPrompt.vue";

// Quasar
const $q = useQuasar();

// Stores
const workspace = useWorkspaceStore();
const auth = useAuthStore();

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
