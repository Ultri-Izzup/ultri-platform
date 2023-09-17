import { defineStore, storeToRefs } from "pinia";
import { Dialog } from "quasar";
import { useStorage } from "@vueuse/core";
import { ref, computed } from "vue";
import { v4 as uuidv4 } from "uuid";
import localforage from "localforage";

import { useAuthStore } from "./auth";

const auth = useAuthStore();

localforage.setDriver(localforage.INDEXEDDB);

// Create an IndexDB database and table to store workspace directory handles.
// The same data directory may be used my multiple apps
const workspaceTable = localforage.createInstance({
  name: "Ultri",
  storeName: "Workspace"
});

/**
 * Track local workspace file and directory handles.
 * This provides a virtual view of the filesystem.
 * Multiple apps can use the same workspace.
 */
export const useWorkspaceStore = defineStore("workspace", () => {

  // Map to store workspace handles by name
  const workspaces = reactive(new Map);

  // SUPPORTED? Does the browser support FileSystem Access API?
  const fsaApiEnabled = computed(() => {
    if (window.showDirectoryPicker) {
      return true;
    } else {
      return false;
    }
  });

  // CREATE a new workspace
  const createWorkspace = async (workspaceName) => {

    try {
      // Only authenticated members can use this feature
      if (!auth.isSignedIn) {
        auth.setSignInRequiredMsg("You must sign in to create a workspace");
        auth.setSignInRequired(true);
      }

      const workspaceDirHandle = await window.showDirectoryPicker({
        id: workspaceName,
        startIn: "documents",
        mode: "readwrite"
      });

      let existingWorkspace = false;

      for await (const e of workspaceDirHandle.entries()) {

        if (e[0] == "ULTRI-WORKSPACE.json") {
          existingWorkspace = true;
        }

        console.log(e);
      }
    } catch (e) {
      return

    }

  };

  // OPEN an existing workspace
  const openWorkspace = async () => {
    // Only authenticated members can use this feature
    if (!auth.isSignedIn) {
      auth.setSignInRequiredMsg("You must sign in to use Cerc");
      auth.setSignInRequired(true);
    }

    //console.log(appDirHandle.resolve())
  };

  // CLEAR all files from a workspace
  const clearWorkspace = async () => {
    // Only authenticated members can use this feature
    if (!auth.isSignedIn) {
      auth.setSignInRequiredMsg("You must sign in to use Cerc");
      auth.setSignInRequired(true);
    }
  };

  // INIT directory with WORKSPACE-MANIFEST.json and directories
  const initWorkspace = async () => {
    // Only authenticated members can use this feature
    if (!auth.isSignedIn) {
      auth.setSignInRequiredMsg("You must sign in to use Cerc");
      auth.setSignInRequired(true);
    }
  };

  // UPGRADE a workspace WORKSPACE-MANIFEST.json and directories
  const upgradeWorkspace = async () => {
    // Only authenticated members can use this feature
    if (!auth.isSignedIn) {
      auth.setSignInRequiredMsg("You must sign in to use Cerc");
      auth.setSignInRequired(true);
    }
  };

  // RESET
  const $reset = () => {
    console.log("RESET CERC");
  };

  return {
    fsaApiEnabled,
    showNameDialog,
    createWorkspace,
    openWorkspace,
    clearWorkspace,
    initWorkspace,
    upgradeWorkspace,
    $reset
  };
});
