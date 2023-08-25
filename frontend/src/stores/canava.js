import { defineStore } from "pinia";
import { useStorage } from "@vueuse/core";

export const useCanavaStore = defineStore("canava", {
  state: () => ({
    canvasData: useStorage("canvasData", { name: "", attribution: "", createdBy: "", createdAt: "", version: "", sections: [] }),
  }),
  getters: {},
  actions: {
    $reset() {
      this.canvasData = { name: "", attribution: "", createdBy: "", createdAt: "", version: "", sections: [] };
    }
  }
});
