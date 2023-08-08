import { defineStore } from "pinia";

import { useStorage } from "@vueuse/core";

const boolFeatures = {
  auth: "authEnabled",
  pricing: "pricingEnabled",
  sociocracy: "sociocracyOnly",
  dashboard: "memberDashboard",
};

export const useFeatureStore = defineStore("feature", {
  state: () => ({
    authEnabled: useStorage("authEnabled", false),
    pricingEnabled: useStorage("pricingEnabled", false),
    sociocracyOnly: useStorage("sociocracyOnly", false),
    memberDashboard: useStorage("memberDashboard", false),
    disabledCanvas: ["delegation", "team", "lean", "coop"],
  }),

  getters: {
    booleans() {
      return boolFeatures;
    },
  },

  actions: {
    reset() {
      this.authEnabled = false;
    },
    enabled(feature) {
      return this[boolFeatures[feature]];
    },
    canvasDisabled(canvas) {
      return this.disabledCanvas.includes(canvas);
    },
  },
});
