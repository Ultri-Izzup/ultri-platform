import { defineStore, storeToRefs  } from "pinia";
import { useStorage } from "@vueuse/core";
import { ref } from "vue";
import { api } from "boot/axios";


export const useMemberStore = defineStore("members", () => {
  const members = ref(useStorage("members", new Map()));
  const currentMemberUid = ref(useStorage("currentMemberUid", null));
  const invites = ref(useStorage("invites", new Map()));
  const currenInviteUid = ref(useStorage("currentInviteUid", null));
  const fetching = ref(false);
  const showMemberInviteDialog = ref(false);

  const setCurrentMember = (uid) => {
    currentMemberUid.value = uid;
  };

  const setCurrentInvite = (uid) => {
    currentInviteUid.value = uid;
  };

  const triggerMemberInviteDialog = () => {
    showMemberInviteDialog.value = true;
  };

  const validateName = (name) => {
    return title.length >= 2 && title.length <= 64;
  };

  const loadMembers = async (orgUid) => {
    const result = await api.get("/orgs/" + orgUid + "/members");

    result.data.orgs.forEach(item => {
      members.value.set(item.uid, item)
    })
  };

  const loadInvites = async (orgUid) => {
    const result = await api.get("/orgs/" + orgUid + "/members");

    result.data.orgs.forEach(item => {
      invites.value.set(item.uid, item)
    })
  };

  const inviteMember = async (orgUid, name, email, roles, circles) => {
    const result = await api.post("/orgs/" + orgUid + "/members/invite", { name: name , email, roles, circles});

    return result.data;
  };

  const cancelInvite = async (orgUid, inviteUid) => {
    const result = await api.post("/orgs/" + orgUid + "/members/invite/cancel", { inviteUid: inviteUid });

    return result.data;
  };

  const updateMember = async (orgUid, memberUid, name, email, roles, circles) => {
    const result = await api.put("/orgs/" + orgUid + "/members/" + memberUid, { name: name , email, roles, circles});

    return result.data;
  };

  const deleteMember = async (orgUid, memberUid) => {
    const result = await api.delete("/orgs/" + orgUid + "/member/" + memberUid);

    orgs.value.delete(uid);
  };

  const $reset = () => {
    console.log(
    'RESET MEMBERS'
    )
    members.value = new Map();
    invites.value = new Map();
    currentMemberUid.value = null;
    currenInviteUid.value = null;
    fetching.value = false;
    showMemberInviteDialog.value = false;
  }

  return {
    members,
    invites,
    currentMemberUid,
    currenInviteUid,
    fetching,
    showMemberInviteDialog,
    setCurrentMember,
    setCurrentInvite,
    triggerMemberInviteDialog,
    validateName,
    loadMembers,
    loadInvites,
    inviteMember,
    cancelInvite,
    updateMember,
    deleteMember
  };
});
