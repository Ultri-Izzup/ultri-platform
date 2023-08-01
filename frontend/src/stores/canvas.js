import { defineStore } from 'pinia';
import { useStorage } from '@vueuse/core';

export const useCanvasStore = defineStore('canvas', {
  state: () => ({
    business: useStorage('business', {}),
    coop: useStorage('coop', {}),
    s3: useStorage('s3', {}),
  }),
  getters: {},
  actions: {
    setCanvasData(canvas, data) {
      this[canvas] = data;
    },
    reset() {
      this.business = {};
      this.coop = {};
      this.s3 = {};
    },
  },
});
