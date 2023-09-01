import { defineStore } from "pinia";
import { useStorage } from "@vueuse/core";

export const useEditorStore = defineStore("editor", {
  state: () => ({
    md: useStorage("md", ''),
    json: useStorage("json", ''),
  }),
  getters: {

  },
  actions: {

    $reset() {
      this.md = null;
      this.json = null;
    }
  }
});
