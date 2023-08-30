import { defineStore } from "pinia";
import { useStorage } from "@vueuse/core";

export const useEditorStore = defineStore("editor", {
  state: () => ({
    md: useStorage("md", null),
    json: useStorage("json", null),
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
