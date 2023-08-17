import { defineStore } from "pinia";

import { useStorage } from "@vueuse/core";

export const useLogbookStore = defineStore("logbook", {
  state: () => ({
    logs: useStorage('logs', [])
  }),

  getters: {

  },

  actions: {
    $reset() {
      this.logs = [];
    }
  }

});
