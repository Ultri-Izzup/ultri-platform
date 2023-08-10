import { defineStore } from "pinia";

import { useStorage } from "@vueuse/core";

const boolFeatures = {
  auth: "authEnabled",
  pricing: "pricingEnabled",
  sociocracy: "sociocracyOnly",
  dashboard: "memberDashboard",
  i18n: "i18nEnabled",
};

export const useFeatureStore = defineStore("feature", {
  state: () => ({
    authEnabled: useStorage('authEnabled', false),
    pricingEnabled: useStorage('pricingEnabled', false),
    sociocracyOnly: useStorage('sociocracyOnly', false),
    memberDashboard: useStorage('memberDashboard', false),
    i18nEnabled: useStorage('i18nEnabled', false),
    enabledLocales: useStorage('enabledLocales', ['en-US','ro']),
    disabledCanvas: useStorage('disabledCanvas', [ 's3team', 'lean', 'coop'])
  }),

  getters: {
    booleans() {
      return boolFeatures;
    },
  },

  actions: {
    $reset() {
      this.authEnabled = false;
      this.pricingEnabled = false;
      this.sociocracyEnabled = false;
      this.memberDashboard = false;
      this.i18nEnabled = false;
      this.enabledLocales = ['en-US','ro'];
      this.disabledCanvas = [ 's3team', 'lean'];
    },
    enabled(feature) {
      return this[boolFeatures[feature]];
    },
    canvasDisabled(canvas) {
      return this.disabledCanvas.includes(canvas);
    },
    setDisabledCanvas(canvasArray) {
      this.disabledCanvas = canvasArray;
    }
  }

});
