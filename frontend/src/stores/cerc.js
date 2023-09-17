import { defineStore, storeToRefs } from "pinia";
import { useStorage } from "@vueuse/core";
import { ref, computed } from "vue";
import { v4 as uuidv4 } from "uuid";
import localforage from 'localforage';

import { useAuthStore } from "./auth";

const auth = useAuthStore();

localforage.setDriver(localforage.INDEXEDDB);

// Create an IndexDB database and table to store a list of projects.
// Each project maps to one local directory.
// The project ID is used as the fsaAPI showDirectoryPicker id.
const projectsTable = localforage.createInstance({
  name: "Ultri",
  storeName: "Projects"
});

// Create an IndexDB database and table to store orgs
const orgsTable = localforage.createInstance({
  name: "Ultri",
  storeName: "Orgs"
});

console.log(orgsTable)

const circleTypes = ["mission", "general", "child"];

export const useCercStore = defineStore("cerc", () => {

  // Does the browser support FileSystemAccess API?
  const fsaApiEnabled = computed(() => {
    if (window.showDirectoryPicker) {
      return true;
    } else {
      return false;
    }
  });

  // Open an app directory
  const openAppDir = async () => {

    // Only authenticated members can use this feature
    if (!auth.isSignedIn) {
      auth.setSignInRequiredMsg("You must sign in to use Cerc");
      auth.setSignInRequired(true);
    }

    const appDirHandle = await window.showDirectoryPicker( {startIn: 'documents', mode: 'readwrite'});
    // Add to IndexDB
    await projectsTable.setItem('cerc1', appDirHandle)

    let isEmpty = true;
    let manifestFound = false;

    // The directory must be empty, or have an ULTRI-WORKSPACE.json file
    for await (const e of appDirHandle.entries()) {
      // Entry found, not an empty directory
      isEmpty = false;

      if (e[0] == "ULTRI-WORKSPACE.json") {
        manifestFound = true;
      }

      console.log(e);
    }

    //console.log(appDirHandle.resolve())
  };

  const $reset = () => {
    console.log("RESET CERC");
  };

  return {
    fsaApiEnabled,
    openAppDir,
    $reset
  };
});
