import { defineStore } from 'pinia';
import { useStorage } from '@vueuse/core';

export const useCanvasStore = defineStore('canvas', {
  state: () => ({
    business: useStorage('business', {
      partners: new Map(),
      activities: new Map(),
      resources: new Map(),
      valueProps: new Map(),
      custRelations: new Map(),
      channels: new Map(),
      custSegments: new Map(),
      costs: new Map(),
      revenue: new Map()
    }),
    coop: useStorage('coop', {
      // Create new maps for each canvgas section
    }),
    s3: useStorage('s3',{
      // Create new maps for each canvgas section
    }),
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
