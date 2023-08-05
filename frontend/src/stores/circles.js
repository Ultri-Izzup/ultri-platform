import { defineStore, storeToRefs  } from "pinia";
import { useStorage } from "@vueuse/core";
import { ref } from "vue";
import { api } from "boot/axios";

export const useCirclesStore = defineStore("circles", () => {

  const circles = ref(useStorage("circles", new Map()));
  const currentCircleUid = ref(useStorage("currentCircleUid", null));
  const topCircleUid = ref(useStorage("topCircleUid", null));
  const fetching = ref(false);
  const showCircleDialog = ref(false);

  const setCurrentCircle = (uid) => {
    currentCircleUid.value = uid;
  };

  const triggerCircleDialog = () => {
    showCircleDialog.value = true;
  };

  const validateCircleName = (orgName) => {
    return orgName.length >= 2 && orgName.length <= 64;
  }

  const createCircle = async (orgUid, circle) => {
    const result = await api.post("/orgs/" + orgUid + '/circles', { circle });

    const circleData = result.data;

    console.log(circleData);
  };

  const updateCircle = async (circle) => {
    const result =  await api.put("/orgs/" + orgUid + '/circles', { circle });

    const circleData = result.data;

    console.log(circleData);
  };

  const $reset = () => {
    console.log(
    'RESET CIRCLES'
    )
    circles.value = new Map();
    currentCircleUid.value = null;
    topCircleUid.value = null;
    fetching.value = false;
    showCircleDialog.value = false;
  }

  return {
    circles,
    currentCircleUid,
    topCircleUid,
    fetching,
    showCircleDialog,
    setCurrentCircle,
    triggerCircleDialog,
    validateCircleName,
    $reset
  };
});
