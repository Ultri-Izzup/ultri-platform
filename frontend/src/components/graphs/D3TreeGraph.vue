<template>
  <q-dialog ref="dialogRef" persistent>
    <q-card class="q-dialog-plugin">
      <q-bar class="dialog-qbar">
          {{ $t("circles.graph.d3Tree.title") }}
          <q-space></q-space>
          <q-btn dense flat icon="mdi-close" v-close-popup @click="reset">
            <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
          </q-btn>
        </q-bar>
      <div id="chart-container"></div>
      Tree visualization
      <pre>{{treeData}}</pre>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, computed, watch, unref } from "vue";
import { useDialogPluginComponent } from "quasar";
import { arrayToTree } from "performant-array-to-tree";

import { useCirclesStore } from "../../stores/circles";
import { useCircleMembersStore } from "../../stores/circleMembers";

const props = defineProps({
  role: String
})

const circlesStore = useCirclesStore();
const circleMembersStore = useCircleMembersStore();

const treeData = computed(() => {
  let tree = [];
  tree = arrayToTree(circlesStore.orgCircles, {
    id: "uid",
    parentId: "parentCircle",
    childrenField: "children",
    dataField: null,
  });

  return tree;
});


const { dialogRef, onDialogOK } = useDialogPluginComponent();
// dialogRef      - Vue ref to be applied to QDialog
// onDialogHide   - Function to be used as handler for @hide on QDialog
// onDialogOK     - Function to call to settle dialog with "ok" outcome
//                    example: onDialogOK() - no payload
//                    example: onDialogOK({ /*...*/ }) - with payload
// onDialogCancel - Function to call to settle dialog with "cancel" outcome

const onOKClick = () => {
  // on OK, it is REQUIRED to
  // call onDialogOK (with optional payload)
  onDialogOK();
  //primary.value = editPrimary.value;
  // or with payload: onDialogOK({ ... })
  // ...and it will also hide the dialog automatically
};


</script>

<style scoped lang="scss">
#chart-container {
  font-family: Arial;
  height: 420px;
  border: 2px dashed #aaa;
  border-radius: 5px;
  overflow: auto;
  text-align: center;
}

.orgchart {
  background: #fff;
}
.orgchart td.left, .orgchart td.right, .orgchart td.top {
  border-color: #aaa;
}
.orgchart td>.down {
  background-color: #aaa;
}
.orgchart .middle-level .title {
  background-color: #006699;
}
.orgchart .middle-level .content {
  border-color: #006699;
}
.orgchart .product-dept .title {
  background-color: #009933;
}
.orgchart .product-dept .content {
  border-color: #009933;
}
.orgchart .rd-dept .title {
  background-color: #993366;
}
.orgchart .rd-dept .content {
  border-color: #993366;
}
.orgchart .pipeline1 .title {
  background-color: #996633;
}
.orgchart .pipeline1 .content {
  border-color: #996633;
}
.orgchart .frontend1 .title {
  background-color: #cc0066;
}
.orgchart .frontend1 .content {
  border-color: #cc0066;
}
</style>
