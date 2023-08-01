import { defineStore } from 'pinia';
import { useStorage } from '@vueuse/core';

export const useNuggetStore = defineStore('canvas', {
  state: () => ({
    business: useStorage('business', {}),
    coop: useStorage('coop', {}),
    s3: useStorage('s3', {}),
  }),
  getters: {},
  actions: {
    reset() {
      this.business = {};
      this.coop = {};
      this.s3 = {};
    },
  },
});
