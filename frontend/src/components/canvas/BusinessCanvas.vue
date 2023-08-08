<template>
  <q-page class="container q-pa-md">
    <CanvasSection
      v-for="info in canvasDef"
      :info="info"
      canvasName="business"
      :key="info.id"
    />
  </q-page>
</template>

<script setup>
import { useI18n } from "vue-i18n";

// Import canvas store
import { useCanvasStore } from "../../stores/canvas";

import CanvasSection from "./CanvasSection.vue";

// Access canvas store
const canvas = useCanvasStore();

// Create i18n accessor as t
const { t } = useI18n();

// Define the canvas sections
const canvasDef = [
  {
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 1,
  },
  {
    title: t("canvas.business.activities.title", "Activities"),
    instructions: t("canvas.business.activities.instructions"),
    class: "key-activities",
    sectionKey: "activities",
    id: 2,
  },
  {
    title: t("canvas.business.resources.title", "Resources"),
    instructions: t("canvas.business.resources.instructions"),
    class: "key-resources",
    sectionKey: "resources",
    id: 3,
  },
  {
    title: t("canvas.business.valuProps.title", "Value Propositions"),
    instructions: t("canvas.business.valueProps.instructions"),
    class: "value-propositions",
    sectionKey: "valueProps",
    id: 4,
  },
  {
    title: t("canvas.business.custRelations.title", "Customer Relations"),
    instructions: t("canvas.business.custRelations.instructions"),
    class: "customer-rel",
    sectionKey: "custRelations",
    id: 5,
  },
  {
    title: t("canvas.business.channels.title", "Channels"),
    instructions: t("canvas.business.channels.instructions"),
    class: "channels",
    sectionKey: "channels",
    id: 6,
  },
  {
    title: t("canvas.business.custSegments.title", "Customer Segments"),
    instructions: t("canvas.business.custSegments.instructions"),
    class: "customer-seg",
    sectionKey: "custSegments",
    id: 7,
  },
  {
    title: t("canvas.business.costs.title", "Costs"),
    instructions: t("canvas.business.costs.instructions"),
    class: "cost-structure",
    sectionKey: "costs",
    id: 8,
  },
  {
    title: t("canvas.business.revenue.title", "Revenue"),
    instructions: t("canvas.business.revenue.instructions"),
    class: "revenue",
    sectionKey: "revenue",
    id: 9,
  },
];
</script>

<style scoped lang="scss">
.container {
  display: grid;
}

// Define the canvas section classes
// @TODO - Add a link to a doc that explains how to create a new canvas and define the CSS.
@media screen and (min-width: 1024px) {
  .container {
    grid-template-columns: repeat(10, 1fr);
    grid-template-rows: repeat(5, 1fr);
    gap: 10px;
    height: 85vh;
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
