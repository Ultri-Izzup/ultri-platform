import { defineStore } from "pinia";
import { useStorage } from "@vueuse/core";
import { v4 as uuidv4 } from "uuid";

import businessModelData from "../data/canava/businessModel.json";
import s3DelegationData from "../data/canava/s3Delegation.json";
import s3OrganizationData from "../data/canava/s3Organization.json";
import s3TeamData from "../data/canava/s3Team.json";
import coopOwnershipData from "../data/canava/coopOwnership.json";
import leanCanvasData from "../data/canava/leanCanvas.json";
import leanUXData from "../data/canava/leanUX.json";
import productVisionBoardData from "../data/canava/productVisionBoard.json";
import productVisionBoardExtData from "../data/canava/productVisionBoardExt.json";
import productCanvasData from "../data/canava/productCanvas.json";

const canvasOpts = [
  {
    label: "Business Model Canvas",
    value: "businessModel",
  },
  {
    label: "Lean Canvas",
    value: "leanCanvas",
  },
  {
    label: "Lean UX Canvas",
    value: "leanUX",
  },
  {
    label: "Product Vision Board",
    value: "productVisionBoard",
  },
  {
    label: "Product Vision Board (extended)",
    value: "productVisionBoardExt",
  },
  {
    label: "Product Canvas",
    value: "productCanvas",
  },
  {
    label: "S3 Organization Canvas",
    value: "s3Organization",
  },
  {
    label: "S3 Delegation Canvas",
    value: "s3Delegation",
  },
  {
    label: "S3 Team Canvas",
    value: "s3Team",
  },
  {
    label: "Co-op Ownership Model",
    value: "coopOwnership",
  },
];

const canvasMap = {
  businessModel: businessModelData,
  s3Delegation: s3DelegationData,
  s3Organization: s3OrganizationData,
  s3Team: s3TeamData,
  coopOwnership: coopOwnershipData,
  leanCanvas: leanCanvasData,
  leanUX: leanUXData,
  productVisionBoard: productVisionBoardData,
  productVisionBoardExt: productVisionBoardExtData,
  productCanvas: productCanvasData,
};

const defaultObject = { name: "", attribution: "", createdBy: "", createdAt: "", version: "", sections: [] }

export const useCanavaStore = defineStore("canava", {
  state: () => ({
    canvasData: useStorage("canvasData", defaultObject),
  }),
  getters: {
    canvasOpts() {
      return canvasOpts;
    }
  },
  actions: {
    loadCanvasTemplate(template) {
      const templateData = canvasMap[template];

      templateData.sections.forEach(function(item, index) {
        if(!item.uid) {
          item.uid = uuidv4();
        }
        console.log(item, index);
      });

      this.canvasData = templateData;

    },
    $reset() {
      this.canvasData = { name: "", attribution: "", createdBy: "", createdAt: "", version: "", sections: [] };
    }
  }
});
