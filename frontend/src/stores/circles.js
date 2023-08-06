import { defineStore, storeToRefs } from "pinia";
import { useStorage } from "@vueuse/core";
import { ref } from "vue";
import { api } from "boot/axios";
import { v4 as uuidv4 } from "uuid";

const circleTypes = ["mission", "general", "child"];

export const useCirclesStore = defineStore("circles", () => {
  const orgCircles = ref(useStorage("orgCircles", []));

  const currentCircleUid = ref(useStorage("currentCircleUid", null));
  const topCircleUid = ref(useStorage("topCircleUid", null));
  const fetching = ref(false);
  const showCirclesDialog = ref(false);

  const setCurrentCircle = (uid) => {
    currentCircleUid.value = uid;
  };

  const triggerCircleDialog = () => {
    console.log('triggered')
    showCirclesDialog.value = true;
  };

  const validateCircleName = (orgName) => {
    return orgName.length >= 2 && orgName.length <= 64;
  };

  const loadCircles = async (orgUid) => {
    // const result = await api.get("/orgs/" + orgUid + '/circles');

    const orgCircles = []; // result.data;
  };

  const createCircle = async (orgUid, circle) => {
    const result = await api.post("/orgs/" + orgUid + "/circles", { circle });

    const circleData = result.data;
  };

  const updateCircle = async (circle) => {
    const result = await api.put("/orgs/" + orgUid + "/circles", { circle });

    const circleData = result.data;

    console.log(circleData);
  };

  const current = (propName) => {
    console.log(propName)
    console.log(currentCircleUid.value)

    const found = orgCircles.value.find((element) => element.uid == currentCircleUid.value);
    console.log(found)

    if(propName) {
      return found[propName]
    }

    return found;


  }

  const initCircles = () => {
    console.log('INIT')

    const missionUid = uuidv4();
    const generalUid = uuidv4();
    const financeUid = uuidv4();
    const productUid = uuidv4();
    const operationsUid = uuidv4();
    const technologyUid = uuidv4();
    const frontendUid = uuidv4();
    const infrastructureUid = uuidv4();
    const testingUid = uuidv4();
    const backendUid = uuidv4();
    const marketingUid = uuidv4();
    const salesUid = uuidv4();
    const socialUid = uuidv4();

    orgCircles.value.push({
      uid: missionUid,
      label: 'Mission',
      parentCircle: null,
      //childCircle: [generalUid]
    });

    orgCircles.value.push({
      uid: generalUid,
      label: 'General',
      parentCircle: missionUid,
      //childCircle: [financeUid, productUid, operationsUid, technologyUid]
    });

    orgCircles.value.push({
      uid: financeUid,
      label: 'Finance',
      parentCircle: generalUid,
      //childCircle: []
    });

    orgCircles.value.push({
      uid: productUid,
      label: 'Product',
      parentCircle: generalUid,
      //childCircle: [marketingUid, salesUid, socialUid]
    });

    orgCircles.value.push({
      uid: operationsUid,
      label: 'Operations',
      parentCircle: generalUid,
      //childCircle: []
    });

    orgCircles.value.push({
      uid: technologyUid,
      label: 'Technology',
      parentCircle: generalUid,
      //childCircle: [frontendUid, infrastructureUid, testingUid]
    });

    orgCircles.value.push({
      uid: frontendUid,
      label: 'Front End',
      parentCircle: technologyUid,
      //childCircle: []
    });

    orgCircles.value.push({
      uid: infrastructureUid,
      label: 'Infrastructure',
      parentCircle: technologyUid,
      //childCircle: []
    });

    orgCircles.value.push({
      uid: backendUid,
      label: 'Back End',
      parentCircle: technologyUid,
      //childCircle: []
    });

    orgCircles.value.push({
      uid: testingUid,
      label: 'Testing',
      parentCircle: technologyUid,
      //childCircle: []
    });

    orgCircles.value.push({
      uid: socialUid,
      label: 'Social',
      parentCircle: productUid,
      //childCircle: []
    });

    orgCircles.value.push({
      uid: salesUid,
      label: 'Sales',
      parentCircle: productUid,
      //childCircle: []
    });

    orgCircles.value.push({
      uid: marketingUid,
      label: 'Marketing',
      parentCircle: productUid,
      //childCircle: []
    });

  }

  const $reset = () => {
    console.log("RESET CIRCLES");
    orgCircles.value = [];
    currentCircleUid.value = null;
    topCircleUid.value = null;
    fetching.value = false;
    showCirclesDialog.value = false;
  };

  return {
    orgCircles,
    currentCircleUid,
    topCircleUid,
    fetching,
    showCirclesDialog,
    current,
    initCircles,
    loadCircles,
    setCurrentCircle,
    triggerCircleDialog,
    validateCircleName,
    $reset
  };
});
