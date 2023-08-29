import { defineStore, storeToRefs } from "pinia";
import { useStorage } from "@vueuse/core";
import { ref, computed } from "vue";
import { api } from "boot/axios";
import { v4 as uuidv4 } from "uuid";

export const useCircleDriversStore = defineStore("circleDrivers", () => {
  const drivers = ref(useStorage("drivers", []));
  const currentDriverUid = ref(useStorage("currentDriverUid", null));
  const currentDriverLabel = ref(useStorage("currentDriverLabel", null));
  const currentDriverDescription = ref(
    useStorage("currentDriverDescription", null)
  );
  const currentDriverInternal = ref(useStorage("currentDriverInternal", true));
  const fetching = ref(false);
  const showCircleDriverDialog = ref(false);
  const showEditDriverDialog = ref(false);

  const hasDrivers = computed(() => drivers.value.length > 0);

  // Provide data formatted for a q-select component
  const driverSelections = computed(() => {
    return drivers.value
      .map((driver) => ({ value: driver.uid, label: driver.label }))
      .sort((a, b) => (a.label > b.label ? 1 : -1));
  });

  const sortDrivers = computed(() => {
    return drivers.value.sort((a, b) => (a.name > b.name ? 1 : -1));
  });

  const driversMap = computed(() => {
    const newMap = new Map();

    drivers.value.forEach((driver) => {
      newMap.set(driver.uid, driver);
    });

    return newMap;
  });

  const getDriverByUid = (driverUid) => {
    console.log(driverUid)
    const ix = drivers.value.findIndex((element) => element.uid == driverUid);
    console.log(ix)
    const data = drivers.value[ix];
    console.log(data)
    return (data)
  }

  const setCurrentDriver = (uid) => {
    currentDriverUid.value = uid;
  };

  const validateName = (name) => {
    return title.length >= 2 && title.length <= 64;
  };

  const loadDrivers = async (orgUid) => {
    const result = await api.get("/orgs/" + orgUid + "/drivers");

    result.data.orgs.forEach((item) => {
      drivers.value.set(item.uid, item);
    });
  };

  const deleteDriver = async (driverUid) => {
    //const result = await api.delete("/orgs/" + orgUid + "/driver/" + driverUid);

    drivers.value.splice(
      drivers.value.findIndex((item) => item.uid === driverUid),
      1
    );
  };

  const addDriver = async (driverObj) => {
    //const result = await api.delete("/orgs/" + orgUid + "/driver/" + driverUid);

    if (driverObj.uid) {
      console.log("update");
    } else {
      driverObj.uid = uuidv4();
      driverObj.createdAt = 'somedate'
      console.log("add");
    }

    drivers.value.push(driverObj);

    return driverObj.uid;
  };

  const triggerCircleDriverDialog = () => {
    console.log("triggeredNewCircleDriver");
    showCircleDriverDialog.value = true;
  };

  const triggerEditDriverDialog = () => {
    console.log("triggeredEditCircleDriver");
    showEditDriverDialog.value = true;
  };

  const $reset = () => {
    console.log("RESET MEMBERS");
    drivers.value = new Map();
    currentDriverUid.value = null;
    fetching.value = false;
    showCircleDriverDialog.value = false;
    showEditDriverDialog.value = false;
    currentDriverInternal.value = true;
  };

  return {
    drivers,
    currentDriverUid,
    fetching,
    showCircleDriverDialog,
    hasDrivers,
    driverSelections,
    sortDrivers,
    driversMap,
    getDriverByUid,
    addDriver,
    setCurrentDriver,
    triggerCircleDriverDialog,
    triggerEditDriverDialog,
    validateName,
    loadDrivers,
    deleteDriver,
    $reset
  };
});
