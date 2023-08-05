import { defineStore } from "pinia";
import { useStorage } from "@vueuse/core";

export const useCanvasStore = defineStore("canvas", {
  state: () => ({
    // The current canvas as defined in URL and set in CanvasPage
    currentCanvas: useStorage("currentCanvas", null),

    // Define top level props for business canvas.
    // These name need to match those configured elsewhere.
    business: useStorage("business", {
      partners: new Map(),
      activities: new Map(),
      resources: new Map(),
      valueProps: new Map(),
      custRelations: new Map(),
      channels: new Map(),
      custSegments: new Map(),
      costs: new Map(),
      revenue: new Map(),
    }),

    // Define top level props for coop ownership canvas.
    coop: useStorage("coop", {
      // Create new maps for each canvgas section
    }),

    // Define top level props for one of the S3 canvas.
    delegation: useStorage("delegation", {
      purpose: new Map(),
      responsibilities: new Map(),
      dependencies: new Map(),
      constraints: new Map(),
      challenges: new Map(),
      deliverables: new Map(),
      competencies: new Map(),
      resources: new Map(),
      delegator: new Map(),
      metrics: new Map(),
      monitoring: new Map(),
      // Create new maps for each canvgas section
    }),
  }),
  getters: {},
  actions: {
    clearCanvas(canvas) {
      switch (canvas) {
        case "business": {
          this.resetBusiness();
          break;
        }
        case "delegation": {
          this.resetDelegation();
          break;
        }
      }
    },
    setCanvasData(canvas, section, data) {
      this[canvas][section] = data;
    },
    $reset() {
      this.resetBusiness();
      this.coop = new Map();
      this.resetDelegation();
    },
    resetBusiness() {
      this.business = {
        partners: new Map(),
        activities: new Map(),
        resources: new Map(),
        valueProps: new Map(),
        custRelations: new Map(),
        channels: new Map(),
        custSegments: new Map(),
        costs: new Map(),
        revenue: new Map(),
      };
    },
    resetDelegation() {
      this.delegation = {
        purpose: new Map(),
        responsibilities: new Map(),
        dependencies: new Map(),
        constraints: new Map(),
        challenges: new Map(),
        deliverables: new Map(),
        competencies: new Map(),
        resources: new Map(),
        delegator: new Map(),
        metrics: new Map(),
        monitoring: new Map(),
      };
    },
  },
});
