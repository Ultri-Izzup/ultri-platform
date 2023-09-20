<template>
  <q-page>
    <div class="text-center justify-center row full-width q-pb-lg text-primary text-bold items-center">
      <span class="text-h2 text-bold">{{ $t("cerc.dashboard.title", 'Workspaces') }}</span><span class="q-pl-md gt-sm text-h3 text-italic">&mdash; {{ getRandTagline() }}</span>
    </div>
    <div class="row full-width">

      <q-card class="full-width">
        <q-tabs
          v-model="tab"

          dense
          class="text-grey"
          active-color="primary"
          indicator-color="primary"
          align="justify"
          narrow-indicator
        >
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
import { ref, computed } from "vue";
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

const tab = ref('technical');

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

// const flowChart =
// "``` /n" +
// `
// mermaid
// sequenceDiagram
//   Webapp-->>Store: A web or mobile app accecss the store
//   Store-->>Map: Pinia stores reactive data in Maps
//   Store-->>IndexDB: Core Maps cached in IndexDB
//   IndexDB-->>Map: Core Maps gets hydrated after reboot
//   Map-->>Store: The store returns Map data
//   Store-->>Workspace: Pinia stores binaries, markdown, and JSON in Workspace directory
//   Workspace-->>GitServer: Git is used to share the data
//   GitServer-->>StaticHosting: Merges auto-deploy to Netlify
//   GitServer-->>Workspace: Revisions are merged into workspace data
//   Workspace-->>Store: The store reads/writes from disk using File System Access API (fsaApi)
//   Store-->>Webapp: The app receives information through the store
// ` + "\n"

const businessMd = ref('');
const personalMd = ref('');
const techDetailsMd = ref('');


// If ref is empty, fetch Markdown and store in ref
if (businessMd.value.length < 1) {
  fetch("/md/workspace/workspace-business-uses.md")
    .then((response) => {
      return response.text();
    })
    .then((responseBody) => {
      businessMd.value = responseBody
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
if (techDetailsMd.value.length < 1) {
  fetch("/md/workspace/workspace-technical-details.md")
    .then((response) => {
      return response.text();
    })
    .then((responseBody) => {
      techDetailsMd.value = responseBody
    });
}

const taglines = [
  'Get it together',
  'Get it easier',
  'Get it done',
  'Get it right',
  'Get if faster',
  'Get if your way',
]

const getRandTagline = () => {
  const index = Math.floor(Math.random() * (taglines.length))
  const randomElement = taglines[index];
  return randomElement;
}
</script>

<style lang="scss">

</style>
