import { defineStore, storeToRefs } from "pinia";
import { useStorage } from "@vueuse/core";
import { ref, computed } from "vue";
import { api } from "boot/axios";
import { v4 as uuidv4 } from "uuid";

const circleTypes = ["mission", "general", "child"];

export const useCirclesStore = defineStore("circles", () => {
  const orgCircles = ref(useStorage("orgCircles", []));

  const currentCircleUid = ref(useStorage("currentCircleUid", null));
  const topCircleUid = ref(useStorage("topCircleUid", null));
  const fetching = ref(false);
  const showCirclesDialog = ref(false);
  const showNewCircleDialog = ref(false);

  const formMode = ref('edit');

  // Provide a q-select proper data to select from all circles
  const circleSelections =  computed(() => {
    return orgCircles.value.map(circle => ({ value: circle.uid, label: circle.label}));
  })

  const setCurrentCircle = (uid) => {
    currentCircleUid.value = uid;
  };

  const triggerCircleDialog = () => {
    console.log('triggered')
    showCirclesDialog.value = true;
  };

  const triggerNewCircleDialog = () => {
    console.log('triggeredNew')
    showNewCircleDialog.value = true;
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

  const addChild = (data) => {

    data.uid = uuidv4();

    orgCircles.value.push(data)

  }

  const deleteCurrent = () => {

    orgCircles.value.splice(orgCircles.value.findIndex(item => item.uid === currentCircleUid.value), 1)

    //console.log(circleData);
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

  const clear = () => {
    $reset();
  }

  const initCircles = () => {
    console.log('INIT')

    const missionUid = uuidv4();
    const generalUid = uuidv4();

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

  }

  const $reset = () => {
    console.log("RESET CIRCLES");
    orgCircles.value = [];
    currentCircleUid.value = null;
    topCircleUid.value = null;
    fetching.value = false;
    showCirclesDialog.value = false;
    showNewCircleDialog.value = false;
  };

  return {
    orgCircles,
    currentCircleUid,
    topCircleUid,
    fetching,
    showCirclesDialog,
    showNewCircleDialog,
    circleSelections,
    formMode,
    clear,
    addChild,
    deleteCurrent,
    current,
    initCircles,
    loadCircles,
    setCurrentCircle,
    triggerCircleDialog,
    triggerNewCircleDialog,
    validateCircleName,
    $reset
  };
});
