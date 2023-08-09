<template>
  <q-page class="container q-pa-md">
    <CanvasSection
      v-for="info in canvasDef"
      :info="info"
      canvasName="s3organization"
      :key="info.id"
    />
  </q-page>
</template>
<script setup>
import CanvasSection from "./CanvasSection.vue";
import { useI18n } from "vue-i18n";
const { t } = useI18n();
const canvasDef = [
  {
    title: t("canvas.s3.organization.drivers.title"),
    instructions: t("canvas.s3.organization.drivers.instructions"),
    class: "drivers",
    sectionKey: "drivers",
    id: 1,
  },
  {
    title: t("canvas.s3.organization.deliverables.title"),
    instructions: t("canvas.s3.organization.deliverables.instructions"),
    class: "deliverables",
    sectionKey: "deliverables",
    id: 2,
  },
  {
    title: t("canvas.s3.organization.customer.title"),
    instructions: t("canvas.s3.organization.customer.instructions"),
    class: "customer",
    sectionKey: "customer",
    id: 3,
  },
  {
    title: t("canvas.s3.organization.proposition.title"),
    instructions: t("canvas.s3.organization.proposition.instructions"),
    class: "proposition",
    sectionKey: "proposition",
    id: 4,
  },
  {
    title: t("canvas.s3.organization.challenges.title"),
    instructions: t("canvas.s3.organization.challenges.instructions"),
    class: "challenges",
    sectionKey: "challenges",
    id: 5,
  },
  {
    title: t("canvas.s3.organization.channels.title"),
    instructions: t("canvas.s3.organization.channels.instructions"),
    class: "channels",
    sectionKey: "channels",
    id: 6,
  },
  {
    title: t("canvas.s3.organization.resources.title"),
    instructions: t("canvas.s3.organization.resources.instructions"),
    class: "resources",
    sectionKey: "resources",
    id: 7,
  },
  {
    title: t("canvas.s3.organization.partners.title"),
    instructions: t("canvas.s3.organization.partners.instructions"),
    class: "partners",
    sectionKey: "partners",
    id: 8,
  },
  {
    title: t("canvas.s3.organization.values.title"),
    instructions: t("canvas.s3.organization.values.instructions"),
    class: "values",
    sectionKey: "values",
    id: 9,
  },
  {
    title: t("canvas.s3.organization.metrics.title"),
    instructions: t("canvas.s3.organization.metrics.instructions"),
    class: "metrics",
    sectionKey: "metrics",
    id: 10,
  },
  {
    title: t("canvas.s3.organization.cost.title"),
    instructions: t("canvas.s3.organization.cost.instructions"),
    class: "cost",
    sectionKey: "cost",
    id: 11,
  },
  {
    title: t("canvas.s3.organization.revenue.title"),
    instructions: t("canvas.s3.organization.revenue.instructions"),
    class: "revenue",
    sectionKey: "revenue",
    id: 12,
  },
];
</script>
<style scoped>
.container {
  display: grid;
}
@media screen and (min-width: 864px) {
  .container {
    grid-template-columns: repeat(8, 1fr);
    grid-template-rows: repeat(7, 1fr);
    height: 130vh;
  }
  .drivers {
    grid-column: 1/3;
    grid-row: 1/3;
  }
  .deliverables {
    grid-column: 3/5;
    grid-row: 1/3;
  }
  .customer {
    grid-column: 5/7;
    grid-row: 1/3;
  }
  .proposition {
    grid-column: 7/9;
    grid-row: 1/3;
  }
  .challenges {
    grid-column: 7/9;
    grid-row: 3/5;
  }
  .channels {
    grid-column: 5/7;
    grid-row: 3/5;
  }
  .resources {
    grid-column: 3/5;
    grid-row: 3/5;
  }
  .partners {
    grid-column: 1/3;
    grid-row: 3/5;
  }
  .values {
    grid-column: 5/9;
    grid-row: 5/7;
  }
  .metrics {
    grid-column: 1/5;
    grid-row: 5/7;
  }
  .cost {
    grid-column: 1/5;
    grid-row: 7/8;
  }
  .revenue {
    grid-column: 5/9;
    grid-row: 7/8;
  }
}
</style>
