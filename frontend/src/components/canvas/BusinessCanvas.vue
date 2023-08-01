<template>
  <q-page class="container q-pa-md">
    <CanvasSection
      v-for="info in canvasDef"
      :info="info"
      :key="info.id"
      :addItem = "addItemToList"
    ></CanvasSection>
  </q-page>
</template>

<script setup>
import CanvasSection from "./CanvasSection.vue";
import { ref } from "vue";
import { nanoid } from "nanoid";

const keyPartners = ref([]);
const keyActivities = ref([]);
const keyResources = ref([]);
const valuePropositions = ref([]);
const customerRel = ref([]);
const channels = ref([]);
const customerSeg = ref([]);
const costStructure = ref([]);
const revenue = ref([]);
function addItemToList(array,text){
  array.push({text:text,id:nanoid()})
}
const canvasDef = [
  {
    title: "Key Partners",
    class: "key-partners",
    id: 1,
    listToRender: keyPartners,
  },
  {
    title: "Key Activities",
    class: "key-activities",
    id: 2,
    listToRender: keyActivities,
  },
  {
    title: "Key Resources",
    class: "key-resources",
    id: 3,
    listToRender: keyResources,
  },
  {
    title: "Value Propositions",
    class: "value-propositions",
    id: 4,
    listToRender: valuePropositions,
  },
  {
    title: "Customer Relations",
    class: "customer-rel",
    id: 5,
    listToRender: customerRel,
  },
  {
    title: "Channels",
    class: "channels",
    id: 6,
    listToRender: channels,
  },
  {
    title: "Customer Segments",
    class: "customer-seg",
    id: 7,
    listToRender: customerSeg,
  },
  {
    title: "Cost Structure",
    class: "cost-structure",
    id: 8,
    listToRender: costStructure,
  },
  { title: "Revenue", class: "revenue", id: 9, listToRender: revenue },
];
</script>


<style lang="scss">
.container {
  height: 85vh;
  display: grid;
  gap: 10px;
}

@media screen and (min-width: 1300px) {
  .container {
    grid-template-columns: repeat(10, 1fr);
    grid-template-rows: repeat(5, 1fr);
  }
  .key-partners {
    grid-column: 1/3;
    grid-row: 1/5;
  }
  .key-activities {
    grid-column: 3/5;
    grid-row: 1/3;
  }
  .key-resources {
    grid-column: 3/5;
    grid-row: 3/5;
  }
  .value-propositions {
    grid-column: 5/7;
    grid-row: 1/5;
  }
  .customer-rel {
    grid-column: 7/9;
    grid-row: 1/3;
  }
  .channels {
    grid-column: 7/9;
    grid-row: 3/5;
  }
  .customer-seg {
    grid-column: 9/11;
    grid-row: 1/5;
  }
  .cost-structure {
    grid-column: 1/6;
    grid-row: 5/6;
  }
  .revenue {
    grid-column: 6/11;
    grid-row: 5/6;
  }
}
</style>
