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
      revenue: new Map()
    }),

    // Define top level props for coop ownership canvas.
    coop: useStorage("coop", {
      // Create new maps for each canvas section
      purpose: new Map(),
      stakeholders: new Map(),
      nonOwnerStakeholders: new Map(),
      benefits: new Map(),
      responsibilities: new Map(),
      governance: new Map(),
      financial: new Map(),
      guidance: new Map(),
      investment: new Map()
    }),

    // Define top level props for one of the S3 canvas.
    s3delegation: useStorage("s3delegation", {
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
      monitoring: new Map()
      // Create new maps for each canvas section
    }),
    s3organization: useStorage("s3organization", {
      drivers: new Map(),
      deliverables: new Map(),
      customer: new Map(),
      proposition: new Map(),
      challenges: new Map(),
      channels: new Map(),
      resources: new Map(),
      resources: new Map(),
      partners: new Map(),
      values: new Map(),
      metrics: new Map(),
      cost: new Map(),
      revenue: new Map()
      // Create new maps for each canvas section
    })
  }),
  getters: {},
  actions: {
    clearCanvas(canvas) {
      switch (canvas) {
        case "business": {
          this.resetBusiness();
          break;
        }
        case "s3delegation": {
          this.resetS3Delegation();
          break;
        }
        case "s3organization": {
          this.resetS3Organization();
          break;
        }
        case "coop": {
          this.resetCoop();
          break;
        }
      }
    },
    setCanvasData(canvas, section, data) {
      this[canvas][section] = data;
    },
    $reset() {
      this.resetBusiness();
      this.resetS3Organization();
      this.resetsS3Delegation();
      this.resetCoop();
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
        revenue: new Map()
      };
    },
    resetS3Delegation() {
      this.s3delegation = {
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
        monitoring: new Map()
      };
    },
    resetS3Organization() {
      this.s3organization = {
        drivers: new Map(),
        deliverables: new Map(),
        customer: new Map(),
        proposition: new Map(),
        challenges: new Map(),
        channels: new Map(),
        resources: new Map(),
        resources: new Map(),
        partners: new Map(),
        values: new Map(),
        metrics: new Map(),
        cost: new Map(),
        revenue: new Map()
      };
    },
    resetCoop() {
      this.coop = {
        purpose: new Map(),
        stakeholders: new Map(),
        nonOwnerStakeholders: new Map(),
        benefits: new Map(),
        responsibilities: new Map(),
        governance: new Map(),
        financial: new Map(),
        guidance: new Map(),
        investment: new Map()
      };
    }
  }
});
