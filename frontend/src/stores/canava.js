import { toValue } from "vue";
import { defineStore } from "pinia";
import { useStorage } from "@vueuse/core";
import { v4 as uuidv4, validate as isValidUUID } from "uuid";

import the4LRetrospectiveData from "../data/canava/the4LRetrospective.json";
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
import kanbanCanvasData from "../data/canava/kanbanCanvas.json";
import swotAnalysisData from "../data/canava/swotAnalysis.json";
import growthHackingData from "../data/canava/growthHacking.json";
import leanChangeData from "../data/canava/leanChange.json";
import pitchCanvasData from "../data/canava/pitchCanvas.json";


import { api } from "boot/axios";

const canvasOpts = [
  {
    label: "Business Model Canvas",
    value: "businessModel"
  },
  {
    label: "Lean Canvas",
    value: "leanCanvas"
  },
  {
    label: "Lean UX Canvas",
    value: "leanUX"
  },
  {
    label: "Lean Change Canvas",
    value: "leanChange"
  },
  {
    label: "4L Retrospective",
    value: "the4LRetrospective"
  },
  {
    label: "Product Vision Board",
    value: "productVisionBoard"
  },
  {
    label: "Product Vision Board (extended)",
    value: "productVisionBoardExt"
  },
  {
    label: "Product Canvas",
    value: "productCanvas"
  },
  {
    label: "SWOT Analysis",
    value: "swotAnalysis"
  },
  {
    label: "S3 Organization Canvas",
    value: "s3Organization"
  },
  {
    label: "S3 Delegation Canvas",
    value: "s3Delegation"
  },
  {
    label: "S3 Team Canvas",
    value: "s3Team"
  },
  {
    label: "Co-op Ownership Model",
    value: "coopOwnership"
  },
  {
    label: "Kanban Canvas",
    value: "kanbanCanvas"
  },
  {
    label: "Growth Hacking",
    value: "growthHacking"
  },
  {
    label: "Pitch Canvas",
    value: "pitchCanvas"
  }
];

const canvasMap = {
  the4LRetrospective: the4LRetrospectiveData,
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
  kanbanCanvas: kanbanCanvasData,
  swotAnalysis: swotAnalysisData,
  growthHacking: growthHackingData,
  leanChange: leanChangeData,
  pitchCanvas: pitchCanvasData
};

const defaultObject = {
  name: "",
  attribution: "",
  createdBy: "",
  createdAt: "",
  version: "",
  sections: []
};

export const useCanavaStore = defineStore("canava", {
  state: () => ({
    canvasData: useStorage("canvasData", defaultObject),
    storedCanvases: useStorage("storedCanvases", {}),
    canvasFh: {},
  }),
  getters: {
    canvasOpts() {
      return canvasOpts;
    },
    canvasMap() {
      return canvasMap;
    },
    openTemplateOpts() {
      const openOpts = [];

      Object.entries(this.storedCanvases).forEach(([canvasId, canvasData]) => {
        if (!isValidUUID(canvasId)) {
          const optsEntry = { label: canvasData.name, value: canvasId };
          openOpts.push(optsEntry);
        }
      });

      return openOpts;
    },
    savedCanvasOpts() {
      const savedOpts = [];

      Object.entries(this.storedCanvases).forEach(([canvasId, canvasData]) => {
        if (isValidUUID(canvasId)) {
          const optsEntry = { label: canvasData.name, value: canvasId };
          savedOpts.push(optsEntry);
        }
      });

      return savedOpts;
    }
  },
  actions: {
    async saveDesignerCanvas() {
      const data = this.canvasData;

      // add the source template to the canvas object
      data.templateName = "custom";

      // new Uid
      const newUuid = uuidv4();

      // add the Uid to the canvas object
      data.uid = newUuid;

      // save to API
      const result = await api.put("/canava/canvases", data);

      // add to savedCanvases using Uid
      this.storedCanvases[newUuid] = data;

      this.resetCanvasData();

      return newUuid;
    },
    async saveTemplateCanvas(canvasTemplate) {
      console.log(canvasTemplate);

      if (isValidUUID(canvasTemplate)) {
        // this has already been saved, we must update it.
        console.log("Updating " + canvasTemplate);
        const data = this.storedCanvases[canvasTemplate];

        // Store on disk
        const fh = this.canvasFh[canvasTemplate];
        fh.value = fh;
        const writable = await fh.value.createWritable();
        await writable.write(JSON.stringify(data, 0, 2));
        await writable.close();


        return canvasTemplate;
      } else {
        console.log("Create new from " + canvasTemplate);
        // get the current data
        const data = this.storedCanvases[canvasTemplate];

        // add the source template to the canvas object
        data.templateName = canvasTemplate;

        // new Uid
        const newUuid = uuidv4();

        // add the Uid to the canvas object
        data.uid = newUuid;
        console.log(toValue(data));

        // add to savedCanvases using Uid
        this.storedCanvases[newUuid] = data;

        console.log(this.storedCanvases[newUuid]);

        // Store on disk
        const fh = await window.showSaveFilePicker({suggestedName: 'canvas.json'});
        console.log(fh);
        this.canvasFh[data.uid] = fh;
        fh.value = fh;
        const writable = await fh.value.createWritable();
        await writable.write(JSON.stringify(data, 0, 2));
        await writable.close();

        // remove template name from savedCanvases
        delete this.storedCanvases[canvasTemplate];

        return data.uid;
      }
    },
    async deleteMemberCanvas(canvasUid) {

        const result = await api.delete("/canava/canvases/" + canvasUid);
        console.log(result)

        if(result) {
          // remove template name from savedCanvases
          delete this.storedCanvases[canvasUid];
        }

    },
    async loadMemberCanvas() {

        // save to API
        const result = await api.get("/canava/canvases");

        console.log(result);

        if(result.data.canvases && result.data.canvases.length > 0) {

          result.data.canvases.forEach((canvas) => {
            this.storedCanvases[canvas.uid] = canvas;
          })
        }

        return result;

    },
    isStored(canvasTemplate) {
        return this.storedCanvases.hasOwnProperty(canvasTemplate);
    },
    loadCanvasTemplate(template) {
      const templateData = canvasMap[template];

      templateData.sections.forEach(function (item, index) {
        if (!item.uid) {
          item.uid = uuidv4();
        }
        //console.log(item, index);
      });

      this.canvasData = templateData;
    },
    loadTemplateCanvas(template) {
      if (!this.storedCanvases[template]) {
        const templateData = canvasMap[template];

        templateData.sections.forEach(function (item, index) {
          if (!item.uid) {
            item.uid = uuidv4();
          }
          //console.log(item, index);
        });

        this.storedCanvases[template] = templateData;
      }
    },
    resetCanvasData() {
      this.canvasData = defaultObject;
    },
    $reset() {
      this.canvasData = {
        name: "",
        attribution: "",
        createdBy: "",
        createdAt: "",
        version: "",
        sections: []
      };
      this.storedCanvases = {};
    }
  }
});
