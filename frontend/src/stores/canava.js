import { defineStore } from "pinia";
import { useStorage } from "@vueuse/core";

export const useCanavaStore = defineStore("canava", {
  state: () => ({
    canvasData: useStorage("canvasData", { name: "", sections: [] }),
  }),
  getters: {},
  actions: {
    $reset() {
      this.canvasData = { name: "", sections: [] };
    }
  }
});
