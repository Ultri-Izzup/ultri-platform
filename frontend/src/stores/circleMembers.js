import { defineStore, storeToRefs  } from "pinia";
import { useStorage } from "@vueuse/core";
import { ref, computed } from "vue";
import { api } from "boot/axios";
import { v4 as uuidv4 } from "uuid";


export const useCircleMembersStore = defineStore("circleMembers", () => {
  const members = ref(useStorage("members", []));
  const currentMemberUid = ref(useStorage("currentMemberUid", null));
  const currentMemberEmail = ref(useStorage("currentMemberEmail", null));
  const currentMemberName = ref(useStorage("currentMemberName", null));
  const invites = ref(useStorage("invites", []));
  const currentInviteUid = ref(useStorage("currentInviteUid", null));
  const fetching = ref(false);
  const showNewCircleMemberDialog = ref(false);
  const showAssignedMemberDialog = ref(false);

  const hasMembers = computed(() => members.value.length > 0);

  // Provide data formatted for a q-select component
  const memberSelections =  computed(() => {
    return members.value.map(member => ({ value: member.uid, label: member.name})).sort((a,b) => (a.label > b.label) ? 1 : -1);
  })

  const sortMembers =  computed(() => {
    return members.value.sort((a,b) => (a.name > b.name) ? 1 : -1);
  })
  const membersMap =  computed(() => {
    const newMap = new  Map();

    members.value.forEach((member) => {
      newMap.set(member.uid, member)
    });

    return newMap;
  })

  const setCurrentMember = (uid) => {
    currentMemberUid.value = uid;
  };

  const setCurrentInvite = (uid) => {
    currentInviteUid.value = uid;
  };

  const triggerMemberInviteDialog = () => {

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

  const deleteMember = async (memberUid) => {
    //const result = await api.delete("/orgs/" + orgUid + "/member/" + memberUid);

    members.value.splice(members.value.findIndex(item => item.uid === memberUid), 1)

  };

  const setMember = async (memberObj) => {
    //const result = await api.delete("/orgs/" + orgUid + "/member/" + memberUid);

    if(memberObj.uid) {
      console.log('update')
    } else {
      memberObj.uid = uuidv4()
      console.log('add')
    }

    members.value.push(memberObj);

    return memberObj.uid;
  };

  const triggerNewCircleMemberDialog = () => {
    console.log('triggeredNewCircleMember')
    showNewCircleMemberDialog.value = true;
  };

  const triggerAssignedMemberDialog = () => {
    console.log('triggeredNewAssignedCircleMember')
    showAssignedMemberDialog.value = true;
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
    showAssignedMemberDialog.value = false;
  }

  return {
    members,
    invites,
    currentMemberUid,
    currentInviteUid,
    fetching,
    showNewCircleMemberDialog,
    showAssignedMemberDialog,
    hasMembers,
    memberSelections,
    sortMembers,
    membersMap,
    setMember,
    setCurrentMember,
    setCurrentInvite,
    triggerMemberInviteDialog,
    triggerNewCircleMemberDialog,
    triggerAssignedMemberDialog,
    validateName,
    loadMembers,
    loadInvites,
    inviteMember,
    cancelInvite,
    updateMember,
    deleteMember,
    $reset
  };
});
