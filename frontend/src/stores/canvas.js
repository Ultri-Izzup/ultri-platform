import { defineStore } from 'pinia';
import { useStorage } from '@vueuse/core';

export const useCanvasStore = defineStore('canvas', {
  state: () => ({
    // The current canvas as defined in URL and set in CanvasPage
    currentCanvas: useStorage('currentCanvas', null),

    // Define top level props for business canvas.
    // These name need to match those configured elsewhere.
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

    // Define top level props for coop ownership canvas.
    coop: useStorage('coop', {
      // Create new maps for each canvgas section
    }),

    // Define top level props for one of the S3 canvas.
    s3: useStorage('s3',{
      // Create new maps for each canvgas section
    }),
  }),
  getters: {},
  actions: {
    setCanvasData(canvas, section, data) {
      this[canvas][section] = data;
    },
    reset() {
      this.business = {
        partners: new Map(),
        activities: new Map(),
        resources: new Map(),
        valueProps: new Map(),
        custRelations: new Map(),
        channels: new Map(),
        custSegments: new Map(),
        costs: new Map(),
        revenue: new Map()
      };
      this.coop = new Map();
      this.s3 = new Map();
    },
  },
});
