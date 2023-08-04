import { defineStore } from 'pinia';

import { useStorage } from '@vueuse/core';

const features = {
  auth: 'authEnabled',
  pricing: 'pricingEnabled'
}

export const useFeatureStore = defineStore('feature', {
  state: () => ({
    authEnabled: false,
    pricingEnabled: false,
  }),

  getters: {

  },

  actions: {
    reset() {
      this.authEnabled = false;
    },
    enabled(feature) {
      return this[features[feature]];
    }
  }
});
