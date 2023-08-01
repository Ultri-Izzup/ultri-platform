import { defineStore } from 'pinia';
import { useStorage } from '@vueuse/core';

export const useCanvasStore = defineStore('canvas', {
  state: () => ({
    business: useStorage('business', new Map()),
    coop: useStorage('coop', new Map()),
    s3: useStorage('s3', new Map()),
  }),
  getters: {},
  actions: {
    setCanvasData(canvas, data) {
      this[canvas] = data;
    },
    reset() {
      this.business = new Map();
      this.coop = new Map();
      this.s3 = new Map();
    },
  },
});
