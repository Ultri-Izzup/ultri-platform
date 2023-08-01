<template>
  <q-page class="container q-pa-md">
    <CanvasSection
      v-for="info in canvasDef"
      :info="info"
      :key="info.id"
    />
  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { nanoid } from "nanoid";
import { useI18n } from "vue-i18n";

import CanvasSection from "./CanvasSection.vue";


// Create i18n accessor as t
const { t } = useI18n();

// Define the canvas sections
const canvasDef = [
  {
    title: t('canvas.business.partner.title'),
    class: "key-partners",
    key: "partners",
    id: 1,
  },
  {
    title: t('canvas.business.activities.title', 'Activities'),
    class: "key-activities",
    key: "activities",
    id: 2,
  },
  {
    title: t('canvas.business.resources.title', 'Resources'),
    class: "key-resources",
    key: "resources",
    id: 3,
  },
  {
    title: t('canvas.business.valuProps.title', 'Value Propositions'),
    class: "value-propositions",
    key: "valueProps",
    id: 4,
  },
  {
    title: t('canvas.business.custRelations.title', 'Customer Relations'),
    class: "customer-rel",
    key: "custRelations",
    id: 5,
  },
  {
    title: t('canvas.business.channels.title', 'Channels'),
    class: "channels",
    key: "channels",
    key: "channels",
    id: 6,
  },
  {
    title: t('canvas.business.custSegments.title', 'Customer Segments'),
    class: "customer-seg",
    key: "custSegments",
    id: 7,
  },
  {
    title: t('canvas.business.costs.title', 'Costs'),
    class: "cost-structure",
    key: "costs",
    id: 8,
  },
  { title: t('canvas.business.revenue.title', 'Revenue'),
  class: "revenue",
  key: "revenue", id: 9 },
];
</script>

<style lang="scss">
.container {
  height: 85vh;
  display: grid;
  gap: 10px;
}

// Define the canvas section classes
// @TODO - Add a link to a doc that explains how to create a new canvas and define the CSS.
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
