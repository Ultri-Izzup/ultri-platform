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
  const showCircleEditorDialog = ref(false);
  const showNewCircleDialog = ref(false);
  const showChildCircleDialog = ref(false);
  const showNewCircleMemberDialog = ref(false);

  const formMode = ref('edit');

  // Provide data formatted for a q-select component
  const circleSelections =  computed(() => {
    return orgCircles.value.map(circle => ({ value: circle.uid, label: circle.label})).sort((a,b) => (a.label > b.label) ? 1 : -1);
  })

  // Provide edges of orgCircles for D3
  const orgCircleEdges2 =  computed(() => {
    return orgCircles.value.filter((c) => c.parentCircle  !== null ).map(circle => ({ source: circle.parentCircle, target: circle.uid, relation: 'child', relation: 'parent', value: 1}));
  });

  const orgCircleEdges =  computed(() => {

    var edges = [];
    orgCircles.value.filter((c) => c.parentCircle  !== null ).forEach(function(e) {
        var sourceNode = orgCircles.value.findIndex(function(n) {
            return n.uid === e.parentCircle;
             }),
            targetNode = orgCircles.value.findIndex(function(n) {
                return n.uid === e.uid;
            });

        edges.push({
            source: sourceNode,
            target: targetNode,
            value: 1
        });
    });

    console.log('EDGES', edges)

    return edges;

  });

  const hasCircles = computed(() => {
    return orgCircles.value.length > 0 ? true : false;
  });

  const setCurrentCircle = (uid) => {
    currentCircleUid.value = uid;
  };

  const triggerCircleEditorDialog = () => {
    console.log('triggered')
    showCircleEditorDialog.value = true;
  };

  const triggerNewCircleDialog = () => {
    console.log('triggeredNew')
    showNewCircleDialog.value = true;
  };

  const triggerChildCircleDialog = () => {
    console.log('triggeredChild')
    showChildCircleDialog.value = true;
  };

  const triggerNewCircleMemberDialog = () => {
    console.log('triggeredNew')
    showNewCircleMemberDialog.value = true;
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

  const addCircle = (data) => {

    const uid = uuidv4();

    data.uid = uid;

    orgCircles.value.push(data)

    return uid;

  }

  const deleteCurrent = () => {

    orgCircles.value.splice(orgCircles.value.findIndex(item => item.uid === currentCircleUid.value), 1)

  };

  const current = (propName) => {
    const found = orgCircles.value.find((element) => element.uid == currentCircleUid.value);

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

  const setCircleRole = async (circleUid, role, memberUid) => {
    // Get the current data
    const ix = orgCircles.value.findIndex((element) => element.uid == circleUid);
    const data = orgCircles.value[ix];

    // Set role to memberUid
    data[role + 'Uid'] = memberUid;

    // Update array with new data
    orgCircles.value[ix] = data;
  }

  const deleteMembers = (membersArr) => {
    orgCircles.value.forEach(circle => {
      if(membersArr.includes(circle.leaderUid)) {
        circle.leaderUid = null;
      }
    })
  }

  const unassignRole = (circleUid, role) => {
    // Get the current data
    const ix = orgCircles.value.findIndex((element) => element.uid == circleUid);
    console.log(ix)
    const data = orgCircles.value[ix];
    console.log(data)

    // Remove role
    delete data[role + 'Uid'];

    // Update array with new data
    orgCircles.value[ix] = data;
  }

  const $reset = () => {
    console.log("RESET CIRCLES");
    orgCircles.value = [];
    currentCircleUid.value = null;
    topCircleUid.value = null;
    fetching.value = false;
    showCircleEditorDialog.value = false;
    showNewCircleDialog.value = false;
    //newCircleParent.value = null;
  };

  return {
    orgCircles,
    currentCircleUid,
    topCircleUid,
    fetching,
    showCircleEditorDialog,
    showNewCircleDialog,
    showChildCircleDialog,
    showNewCircleMemberDialog,
    circleSelections,
    formMode,
    hasCircles,
    orgCircleEdges,
    unassignRole,
    deleteMembers,
    setCircleRole,
    clear,
    addCircle,
    deleteCurrent,
    current,
    initCircles,
    loadCircles,
    setCurrentCircle,
    triggerCircleEditorDialog,
    triggerNewCircleDialog,
    triggerChildCircleDialog,
    triggerNewCircleMemberDialog,
    validateCircleName,
    $reset
  };
});
