<template>
  <q-page class="container q-pa-md">
    <CanvasSection
      v-for="info in canvasDef"
      :info="info"
      canvasName="delegation"
      :key="info.id"
    />
  </q-page>
</template>
<script setup>
import { useI18n } from "vue-i18n";
import CanvasSection from "./CanvasSection.vue";
const { t } = useI18n();
const canvasDef = [
  {
    title: t("canvas.s3.delegation.purpose.title"),
    instructions: t("canvas.s3.delegation.purpose.instructions"),
    class: "purpose",
    sectionKey: "purpose",
    id: 1,
  },
  {
    title: t("canvas.s3.delegation.responsabilities.title"),
    instructions: t("canvas.s3.delegation.responsabilities.instructions"),
    class: "responsabilities",
    sectionKey: "responsabilities",
    id: 2,
  },
  {
    title: t("canvas.s3.delegation.dependencies.title"),
    instructions: t("canvas.s3.delegation.dependencies.instructions"),
    class: "dependencies",
    sectionKey: "dependencies",
    id: 3,
  },
  {
    title: t("canvas.s3.delegation.constraints.title"),
    instructions: t("canvas.s3.delegation.constraints.instructions"),
    class: "constraints",
    sectionKey: "constraints",
    id: 4,
  },
  {
    title: t("canvas.s3.delegation.challenges.title"),
    instructions: t("canvas.s3.delegation.challenges.instructions"),
    class: "challenges",
    sectionKey: "challenges",
    id: 5,
  },
  {
    title: t("canvas.s3.delegation.deliverables.title"),
    instructions: t("canvas.s3.delegation.deliverables.instructions"),
    class: "deliverables",
    sectionKey: "deliverables",
    id: 6,
  },
  {
    title: t("canvas.s3.delegation.competencies.title"),
    instructions: t("canvas.s3.delegation.competencies.instructions"),
    class: "competencies",
    sectionKey: "competencies",
    id: 7,
  },
  {
    title: t("canvas.s3.delegation.resources.title"),
    instructions: t("canvas.s3.delegation.resources.instructions"),
    class: "resources",
    sectionKey: "resources",
    id: 8,
  },
  {
    title: t("canvas.s3.delegation.delegator.title"),
    instructions: t("canvas.s3.delegation.delegator.instructions"),
    class: "delegator",
    sectionKey: "delegator",
    id: 9,
  },
  {
    title: t("canvas.s3.delegation.metrics.title"),
    instructions: t("canvas.s3.delegation.metrics.instructions"),
    class: "metrics",
    sectionKey: "metrics",
    id: 10,
  },
  {
    title: t("canvas.s3.delegation.monitoring.title"),
    instructions: t("canvas.s3.delegation.monitoring.instructions"),
    class: "monitoring",
    sectionKey: "monitoring",
    id: 11,
  },
];
</script>
<style>
@media screen and (min-width: 1024px) {
  .container {
    /* grid-template-columns: repeat(10, 1fr);
    grid-template-rows: repeat(5, 1fr); */
    gap: 10px;
    height: 85vh;
  }
  .purpose {
  }
  .responsabilities {
  }
  .dependencies {
  }
  .constraints {
  }
  .challenges {
  }
  .deliverables {
  }
  .competencies {
  }
  .resources {
  }
  .delegator {
  }
  .metrics {
  }
  .monitoring {
  }
}
</style>
