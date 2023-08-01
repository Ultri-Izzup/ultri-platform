<template>
  <q-page class="container q-pa-md">
    <pre>

  </pre>
    <CanvasSection
      v-for="info in canvasDef"
      :info="info"
      :key="info.id"
      :currentData="currentData[info.key]"
    />
  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { nanoid } from "nanoid";
import { useI18n } from "vue-i18n";

import CanvasSection from "./CanvasSection.vue";

const props = defineProps({
  currentData: Object
})

// Create i18n accessor as t
const { t } = useI18n();

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
  array.push({text,id:nanoid()})
}
function editItemToList(arr,id,textToBeEdited){
  let elementToFind= arr.find(element=>element.id===id);
  elementToFind.text=textToBeEdited;
}
const canvasDef = [
  {
    title: t('canvas.business.partner.title'),
    class: "key-partners",
    key: "partners",
    id: 1,
    listToRender: keyPartners,
  },
  {
    title: "Key Activities",
    class: "key-activities",
    key: "activities",
    id: 2,
    listToRender: keyActivities,
  },
  {
    title: "Key Resources",
    class: "key-resources",
    key: "resources",
    id: 3,
    listToRender: keyResources,
  },
  {
    title: "Value Propositions",
    class: "value-propositions",
    key: "valueProps",
    id: 4,
    listToRender: valuePropositions,
  },
  {
    title: "Customer Relations",
    class: "customer-rel",
    key: "custRelations",
    id: 5,
    listToRender: customerRel,
  },
  {
    title: "Channels",
    class: "channels",
    key: "channels",
    key: "channels",
    id: 6,
    listToRender: channels,
  },
  {
    title: "Customer Segments",
    class: "customer-seg",
    key: "custSegments",
    id: 7,
    listToRender: customerSeg,
  },
  {
    title: "Cost Structure",
    class: "cost-structure",
    key: "costs",
    id: 8,
    listToRender: costStructure,
  },
  { title: "Revenue", class: "revenue", key: "revenue", id: 9, listToRender: revenue },
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
