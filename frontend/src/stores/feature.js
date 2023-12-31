import { defineStore } from "pinia";

import { useStorage } from "@vueuse/core";

const boolFeatures = {
  auth: "authEnabled",
  pricing: "pricingEnabled",
  sociocracy: "sociocracyOnly",
  dashboard: "memberDashboard",
  i18n: "i18nEnabled",
  db: "dbEnabled"
};

export const useFeatureStore = defineStore("feature", {
  state: () => ({
    authEnabled: useStorage('authEnabled', true),
    pricingEnabled: useStorage('pricingEnabled', false),
    sociocracyOnly: useStorage('sociocracyOnly', false),
    memberDashboard: useStorage('memberDashboard', false),
    i18nEnabled: useStorage('i18nEnabled', false),
    dbEnabled: useStorage('dbEnabled', false),
    enabledLocales: useStorage('enabledLocales', ['en-US','ro']),
    disabledCanvas: []
  }),

  getters: {
    booleans() {
      return boolFeatures;
    },
  },

  actions: {
    $reset() {
      this.authEnabled = true;
      this.pricingEnabled = false;
      this.sociocracyEnabled = false;
      this.memberDashboard = false;
      this.i18nEnabled = false;
      this.dbEnabled = false;
      this.enabledLocales = ['en-US','ro'];
      this.disabledCanvas = [ ];
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
