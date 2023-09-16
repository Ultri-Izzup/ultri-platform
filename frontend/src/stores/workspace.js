import { defineStore, storeToRefs } from "pinia";
import { useStorage } from "@vueuse/core";
import { ref, computed } from "vue";
import { v4 as uuidv4 } from "uuid";
import localforage from 'localforage';

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

  // SUPPORTED? Does the browser support FileSystem Access API?
  const fsaApiEnabled = computed(() => {
    if (window.showDirectoryPicker) {
      return true;
    } else {
      return false;
    }
  });

  // CREATE a new workspace
  const createWorkspace = async () => {

    // Only authenticated members can use this feature
    if (!auth.isSignedIn) {
      auth.setSignInRequiredMsg("You must sign in to use Cerc");
      auth.setSignInRequired(true);
    }

    const tempDirHandle = await window.showDirectoryPicker( { startIn: 'documents', mode: 'readwrite'});
    // Add to IndexDB
    // await projectsTable.setItem('cerc1', appDirHandle)

    let isEmpty = true;
    let manifestFound = false;

    // The directory must be empty, or have an ULTRI-MANIFEST.json file
    for await (const e of appDirHandle.entries()) {
      // Entry found, not an empty directory
      isEmpty = false;

      if (e[0] == "ULTRI-MANIFEST.json") {
        manifestFound = true;
      }

      console.log(e);
    }

    if(isEmpty) {
      // Prompt for a dataDir nickname/alias
      this.$q.dialog({
                title: "Existing Files Found!",
                message:
                  "Files were found in the directory, you must start in a empty directory.",
                cancel: false,
                persistent: true,
              })
              .onOk((data) => {});


      // Create a new filehandle with the alias as the id.
      // This will allow accessing this directory by its alias.

    } else if (manifestFound) {

    } else {

    }

    //console.log(appDirHandle.resolve())
  };

  // OPEN an existing workspace
  const openWorkspace = async () => {

    // Only authenticated members can use this feature
    if (!auth.isSignedIn) {
      auth.setSignInRequiredMsg("You must sign in to use Cerc");
      auth.setSignInRequired(true);
    }

    const tempDirHandle = await window.showDirectoryPicker( { startIn: 'documents', mode: 'readwrite'});
    // Add to IndexDB
    // await projectsTable.setItem('cerc1', appDirHandle)

    let isEmpty = true;
    let manifestFound = false;

    // The directory must be empty, or have an ULTRI-MANIFEST.json file
    for await (const e of appDirHandle.entries()) {
      // Entry found, not an empty directory
      isEmpty = false;

      if (e[0] == "ULTRI-MANIFEST.json") {
        manifestFound = true;
      }

      console.log(e);
    }

    if(isEmpty) {
      // Prompt for a dataDir nickname/alias
      this.$q.dialog({
                title: "Existing Files Found!",
                message:
                  "Files were found in the directory, you must start in a empty directory.",
                cancel: false,
                persistent: true,
              })
              .onOk((data) => {});


      // Create a new filehandle with the alias as the id.
      // This will allow accessing this directory by its alias.

    } else if (manifestFound) {

    } else {

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
    createWorkspace,
    openWorkspace,
    clearWorkspace,
    initWorkspace,
    upgradeWorkspace,
    $reset
  };
});
