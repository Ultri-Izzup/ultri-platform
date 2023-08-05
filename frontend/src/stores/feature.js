import { defineStore } from 'pinia';

import { useStorage } from '@vueuse/core';

const boolFeatures = {
  auth: 'authEnabled',
  pricing: 'pricingEnabled',
}

export const useFeatureStore = defineStore('feature', {
  state: () => ({
    authEnabled: false,
    pricingEnabled: false,
    disabledCanvas: [ 'delegation', 'team', 'organization', 'lean', 'coop']
  }),

  getters: {
    booleans() {
      return boolFeatures;
    }
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
    }
  }
});
