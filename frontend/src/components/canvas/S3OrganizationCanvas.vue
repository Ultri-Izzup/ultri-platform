<template>
  <q-page class="container q-pa-md">
    <CanvasSection
      v-for="info in canvasDef"
      :info="info"
      canvasName="organization"
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
    title: t("ccanvas.s3.organization.channels.title"),
    instructions: t("ccanvas.s3.organization.channels.instructions"),
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
  .drivers {
  }
  .deliverables {
  }
  .customer {
  }
  .proposition {
  }
  .challenges {
  }
  .channels {
  }
  .resources {
  }
  .partners {
  }
  .values {
  }
  .metrics {
  }
  .cost {
  }
  .revenue {
  }
}
</style>
