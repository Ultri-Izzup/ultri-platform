import { defineStore } from "pinia";
import { useStorage } from "@vueuse/core";

export const useEditorStore = defineStore("editor", {
  state: () => ({
    md: useStorage("md", ""),
    json: useStorage("json", ""),
    jsonSchema: useStorage("jsonSchema", "{root: { type: 'object' } }")
  }),
  getters: {},
  actions: {
    $reset() {
      this.md = null;
      this.json = null;
      this.jsonSchema = "{root: { type: 'object' } }";
    }
  }
});
