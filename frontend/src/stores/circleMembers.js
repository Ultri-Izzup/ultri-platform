import { defineStore, storeToRefs  } from "pinia";
import { useStorage } from "@vueuse/core";
import { ref } from "vue";
import { api } from "boot/axios";


export const useCircleMembersStore = defineStore("circleMembers", () => {
  const members = ref(useStorage("members", []));
  const currentMemberUid = ref(useStorage("currentMemberUid", null));
  const invites = ref(useStorage("invites", []));
  const currentInviteUid = ref(useStorage("currentInviteUid", null));
  const fetching = ref(false);
  const showNewCircleMemberDialog = ref(false);

  const setCurrentMember = (uid) => {
    currentMemberUid.value = uid;
  };

  const setCurrentInvite = (uid) => {
    currentInviteUid.value = uid;
  };

  const triggerMemberInviteDialog = () => {
    showNewCircleMemberDialog.value = true;
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
    currentInviteUid.value = null;
    fetching.value = false;
    showNewCircleMemberDialog.value = false;
  }

  return {
    members,
    invites,
    currentMemberUid,
    currentInviteUid,
    fetching,
    showNewCircleMemberDialog,
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
