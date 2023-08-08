import { defineStore, storeToRefs  } from "pinia";
import { useStorage } from "@vueuse/core";
import { ref, watch} from "vue";
import { api } from "boot/axios";


export const useOrgStore = defineStore("org", () => {
  const orgs = ref(useStorage("orgs", new Map()));
  const logbookEntries = ref(useStorage("logbookEntries", new Map()));
  const currentOrgUid = ref(useStorage("currentOrgUid", null));
  const fetching = ref(false);
  const fetched = ref(false);
  const showOrgCreateDialog = ref(false);
  const showOrgMissionDialog = ref(false);
  const showOrgCreateLogbookEntryDialog = ref(false);

  const setCurrentOrg = (uid) => {
    currentOrgUid.value = uid;
  };

  const triggerOrgCreateDialog = () => {
    showOrgCreateDialog.value = true;
  };

  const triggerOrgMissionDialog = () => {
    showOrgMissionDialog.value = true;
  };

  const triggerOrgCreateLogbookEntryDialog = () => {
    showOrgCreateLogbookEntryDialog.value = true;
  };

  const validateOrgName = (orgName) => {
    if (orgName === null) {
      return false;
    }
    return orgName.length >= 2 && orgName.length <= 64;
  }
  const validateTitle = (title) => {
    return title.length >= 2 && title.length <= 64;
  };
  const validateMission = (mission) => {
    return mission.length >= 2 && mission.length <= 1024;
  };

  const loadOrgs = async () => {
    const result = await api.get("/orgs");

    result.data.orgs.forEach(item => {
      orgs.value.set(item.uid, item)
    })
  };

  const loadLogbookEntries = async (orgUid) => {

    // console.log(orgUid);

    const result = await api.get("/orgs/" + orgUid + "/logbook/entries");

    console.log(result)

    const data = result.data.logbookEntries;

    data.forEach(item => {
      logbookEntries.value.set(item.logbookEntryUid, item)
    })

  };

  const createOrg = async (name) => {
    const result = await api.post("/orgs", { name: name });

    const orgData = result.data;

    orgs.value.set(orgData.uid, orgData);

    showOrgCreateDialog.value = null;

    return orgData;
  };

  const setOrgMission = async (orgUid, mission) => {
    const result = await api.put("/orgs/" + orgUid + '/mission', {mission : mission });

    const data = result.data;

    orgs.value.set(orgData.uid, orgData);

    showOrgCreateDialog.value = null;

    return orgData;
  };

  const deleteMemberOrg = async (uid) => {
    const result = await api.delete("/orgs/" + uid);

    orgs.value.delete(uid);
  };

  const $reset = () => {
    console.log(
    'RESET ORGS'
    )
    orgs.value = new Map();
    logbookEntries.value = new Map();
    currentOrgUid.value = null;
    fetching.value = false;
    showOrgCreateDialog.value = false;
    showOrgMissionDialog.value = false;
    showOrgCreateLogbookEntryDialog.value = false;
  }

  return {
    orgs,
    currentOrgUid,
    logbookEntries,
    fetching,
    fetched,
    showOrgCreateDialog,
    showOrgMissionDialog,
    showOrgCreateLogbookEntryDialog,
    loadOrgs,
    setCurrentOrg,
    setOrgMission,
    triggerOrgCreateDialog,
    triggerOrgMissionDialog,
    triggerOrgCreateLogbookEntryDialog,
    validateOrgName,
    validateTitle,
    validateMission,
    createOrg,
    deleteMemberOrg,
    loadLogbookEntries,
    setOrgMission,
    $reset
  };
});
