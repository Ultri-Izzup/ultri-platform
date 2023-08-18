import { defineStore, storeToRefs } from "pinia";
import { useStorage } from "@vueuse/core";
import { ref, computed } from "vue";
import { api } from "boot/axios";
import { v4 as uuidv4 } from "uuid";

export const useCircleOKRStore = defineStore("circleOKR", () => {
  const okrs = ref(useStorage("okrs", []));
  const currentOKRUid = ref(useStorage("currentOKRUid", null));
  const currentOKRLabel = ref(useStorage("currentOKRLabel", null));
  const currentOKRDescription = ref(
    useStorage("currentOKRDescription", null)
  );

  const fetching = ref(false);
  const showCircleOKRDialog = ref(false);
  const showEditOKRDialog = ref(false);
  const showCircleKeyResultDialog = ref(false);

  const hasOKRs = computed(() => okrs.value.length > 0);

  // Provide data formatted for a q-select component
  const okrSelections = computed(() => {
    return okrs.value
      .map((okr) => ({ value: okr.uid, label: okr.label }))
      .sort((a, b) => (a.label > b.label ? 1 : -1));
  });

  const sortOKRs = computed(() => {
    return okrs.value.sort((a, b) => (a.name > b.name ? 1 : -1));
  });

  const okrsMap = computed(() => {
    const newMap = new Map();

    okrs.value.forEach((okr) => {
      newMap.set(okr.uid, okr);
    });

    return newMap;
  });

  const getOKRByUid = (okrUid) => {
    console.log(okrUid)
    const ix = okrs.value.findIndex((element) => element.uid == okrUid);
    console.log(ix)
    const data = okrs.value[ix];
    console.log(data)
    return (data)
  }

  const setCurrentOKR = (uid) => {
    currentOKRUid.value = uid;
  };

  const validateName = (name) => {
    return title.length >= 2 && title.length <= 64;
  };

  const loadOKRs = async (orgUid) => {
    const result = await api.get("/orgs/" + orgUid + "/okrs");

    result.data.orgs.forEach((item) => {
      okrs.value.set(item.uid, item);
    });
  };

  const deleteOKR = async (okrUid) => {
    //const result = await api.delete("/orgs/" + orgUid + "/okr/" + okrUid);

    okrs.value.splice(
      okrs.value.findIndex((item) => item.uid === okrUid),
      1
    );
  };

  const addOKR = async (okrObj) => {
    //const result = await api.delete("/orgs/" + orgUid + "/okr/" + okrUid);

    if (okrObj.uid) {
      console.log("update");
    } else {
      okrObj.uid = uuidv4();
      okrObj.createdAt = 'somedate'
      console.log("add");
    }

    okrs.value.push(okrObj);

    return okrObj.uid;
  };

  const triggerCircleOKRDialog = () => {
    showCircleOKRDialog.value = true;
  };

  const triggerEditOKRDialog = () => {
    showEditOKRDialog.value = true;
  };

  const triggerCircleKeyResultDialog = () => {
    console.log('TRIGGERD')
    showCircleKeyResultDialog.value = true;
  };

  const $reset = () => {
    console.log("RESET MEMBERS");
    okrs.value = new Map();
    invites.value = new Map();
    currentOKRUid.value = null;
    fetching.value = false;
    showCircleOKRDialog.value = false;
    showEditOKRDialog.value = false;
    showKeyResultDialog.value = false;
    currentOKRInternal.value = true;
  };

  return {
    okrs,
    currentOKRUid,
    fetching,
    showCircleOKRDialog,
    showCircleKeyResultDialog,
    hasOKRs,
    okrSelections,
    sortOKRs,
    okrsMap,
    getOKRByUid,
    addOKR,
    setCurrentOKR,
    triggerCircleOKRDialog,
    triggerEditOKRDialog,
    triggerCircleKeyResultDialog,
    validateName,
    loadOKRs,
    deleteOKR,
    $reset
  };
});
