import { ref, reactive, computed } from "vue";
import { defineStore, storeToRefs } from "pinia";
import { useStorage } from "@vueuse/core";
import { Dialog } from "quasar";


// import { v4 as uuidv4 } from "uuid";
import { nanoid } from 'nanoid';
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

  // Have the workspaces ben loaded from IndexDB to a Map?
  const workspacesLoaded = ref(false);

  // Map to store workspace handles by name
  const workspaceMap = reactive(new Map);

  // SUPPORTED? Does the browser support FileSystem Access API?
  const fsaApiEnabled = computed(() => {
    if (window.showDirectoryPicker) {
      return true;
    } else {
      return false;
    }
  });

  // CREATE a new workspace
  const createWorkspace = async (workspaceAlias) => {

    console.log('CREATING', workspaceAlias)

    try {
      authCheck();

      const newUid = nanoid();
      console.log(newUid)

      const workspaceDirHandle = await window.showDirectoryPicker({
        id: workspaceAlias,
        startIn: "documents",
        mode: "readwrite",
      });

      const workspaceObject = {
        alias: workspaceAlias,
        uid: newUid,
        createdAt: new Date().toISOString(),
        dirHandle: workspaceDirHandle
      }

      // Store reactive value in Map
      workspaceMap.set(workspaceAlias, workspaceObject)

      // Store in IndexDB to persist through reboot
      workspaceTable.setItem(workspaceAlias, workspaceObject)

    } catch (e) {
      console.log(e)

    }

  };

  // OPEN an existing workspace
  const openWorkspace = async () => {
    authCheck();

  };

  // CLEAR all files from a workspace
  const clearWorkspace = async () => {
    authCheck();
  };

  // INIT directory with WORKSPACE-MANIFEST.json and directories
  const initWorkspace = async () => {
    authCheck();
  };

  // UPGRADE a workspace WORKSPACE-MANIFEST.json and directories
  const upgradeWorkspace = async () => {
    authCheck();
  };

  // LOAD LIST of Workspaces from IndexDB, refresh the store's Map
  const loadWorkspaces = async () => {
    workspaceTable.iterate(function(value, key, ix) {
      console.log([key, value]);
      workspaceMap.set(key, value);
  }).then(function() {
      workspacesLoaded.value = true;
  }).catch(function(err) {
      console.log(err);
  });
  }

  // LOAD a SINGLE Workspace from disk
  const loadWorkspace = async (workspaceAlias) => {
    // Get the aliases directory handle
    const workspaceDirHandle = workspaceMap.get(workspaceAlias).dirHandle;

    // Loop through directory contents.
    console.log(workspaceDirHandle);

    // Store all file and dir handles in the local Map.
    // Store key file and directory handles in IndexDb.
  }

  // RESET
  const $reset = () => {
    console.log("Reset Workspace");
    workspacesLoaded.value = false;
    workspaceMap.clear();
  };

  const authCheck = () => {
    // Only authenticated members can use this feature
    if (!auth.isSignedIn) {
      auth.setSignInRequiredMsg("Sign in to create a workspace");
      auth.setSignInRequired(true);
      auth.setTargetUrl(null);
    }
    return;
  }

  const validWorkspaceAlias = (workspaceAlias) => {
    return /[a-z0-9_-]{1,32}$/.test(workspaceAlias);
  }

  return {
    fsaApiEnabled,
    workspaceMap,
    loadWorkspace,
    loadWorkspaces,
    createWorkspace,
    openWorkspace,
    clearWorkspace,
    initWorkspace,
    upgradeWorkspace,
    authCheck,
    validWorkspaceAlias,
    $reset
  };
});
