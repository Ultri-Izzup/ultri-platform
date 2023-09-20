<template>
  <div>
  <div v-if="route.params.workspaceAlias">
    <div class="row">
      <span class="col-3">
        <q-btn @click="triggerWorkspaceDialog()" icon="mdi-plus" dense size="lg" class="q-ma-sm"></q-btn>
      </span><span class="col q-pr-sm">
        <q-select v-model="selectedWorkspace" :options="Array.from(workspace.workspaceMap.keys())"
          @update:model-value="val => router.push({ name: 'workspaceDashboard', params: { workspaceAlias: val } })"
          class="full-width" />
      </span>
    </div>
    <q-separator></q-separator>
  </div>
  <div v-else>
    <q-card flat>
      <q-card-section>
        <div class="full-width text-center text-h3 text-italic text-bold q-pt-lg">Get Started</div>
      </q-card-section>

      <div v-if="workspace.fsaApiEnabled" class="q-pb-lg">
        <q-card-actions class="justify-center">
          <q-btn @click="triggerWorkspaceDialog()" label="Create Workspace" class="u-btn-cta" size="lg"></q-btn>
        </q-card-actions>
        <q-card-actions v-if="workspace.workspaceMap.size > 0" class="justify-center q-pb-xl">
          <q-select v-model="selectedWorkspace" :options="Array.from(workspace.workspaceMap.keys())"
            @update:model-value="val => router.push({ name: 'workspaceDashboard', params: { workspaceAlias: val } })"
            style="width: 80%" />
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
    <UDialogPrompt v-model="showWorkspaceDialog" toolbar-text="Create Workspace" headline-text="Workspace Alias"
      instructions-text="Enter a name or alias to use, then choose the directory."
      label-text="32 characters or less, no special characters" button-text="Choose Directory"
      :validator="(str) => { return !(str && /^[A-Za-z0-9_-]{1,32}$/.test(str)); }"
      @ok="(event) => workspace.createWorkspace(event)"></UDialogPrompt>

  </div>
</template>

<script setup>
import { ref, watch } from "vue";
import { useRoute, useRouter } from "vue-router";

import { useWorkspaceStore } from "../../stores/workspace";
import { useAuthStore } from "../../stores/auth";

import UDialogPrompt from "../../components/ultri/dialog/UDialogPrompt.vue";

const route = useRoute();
const router = useRouter();

// Stores
const workspace = useWorkspaceStore();
const auth = useAuthStore();

const selectedWorkspace = ref(null);

workspace.loadWorkspaces();

// Alias for a new or current Workspace
const workspaceAlias = ref();
const showWorkspaceDialog = ref(false);

// Display dialog to collect info for a new workspace
const triggerWorkspaceDialog = async () => {
  // Display a dialog to collect the workspace name
  showWorkspaceDialog.value = true;
};

watch(
  () => route.params.workspaceAlias,
  () => {
    if (route.params.workspaceAlias) {
      selectedWorkspace.value = route.params.workspaceAlias;
      workspace.loadWorkspace(route.params.workspaceAlias);
    } else {
      selectedWorkspace.value = null;
    }
  },
  { immediate: true }
);
</script>

<style lang="scss">
</style>
