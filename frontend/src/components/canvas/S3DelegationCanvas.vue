<template>
  <q-page class="flex flex-center" v-if="ufs.canvasDisabled('delegation')"
    ><q-card
      ><q-card-section class="q-pa-xl"
        ><div class="text-h2">{{$t('canvas.s3.delegation.name')}}</div>
        <div class="text-h2">{{$t('canvas.comingSoon')}}</div></q-card-section
      ></q-card
    ></q-page
  >
  <q-page v-else class="container q-pa-md">
      <CanvasSection
        v-for="info in canvasDef"
        :info="info"
        canvasName="s3delegation"
        :key="info.id"
      />
  </q-page>
</template>
<script setup>
import { useI18n } from "vue-i18n";

import CanvasSection from "./CanvasSection.vue";

import { useCanvasStore } from "../../stores/canvas";
import { useFeatureStore } from "../../stores/feature";

const canvas = useCanvasStore();
const ufs = useFeatureStore();

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
    title: t("canvas.s3.delegation.responsibilities.title"),
    instructions: t("canvas.s3.delegation.responsibilities.instructions"),
    class: "responsibilities",
    sectionKey: "responsibilities",
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
<style scoped>
.container {
  display: grid;
}
@media screen and (min-width: 1024px) {
  .container {
    grid-template-columns: repeat(12, 1fr);
    grid-template-rows: repeat(12, 1fr);
    gap: 10px;
    height: 85vh;
  }
  .purpose {
    grid-row: 1/6;
    grid-column: 1/4;
  }
  .responsibilities {
    grid-row: 1/6;
    grid-column: 4/7;
  }
  .dependencies {
    grid-row: 1/6;
    grid-column: 7/10;
  }
  .constraints {
    grid-row: 1/6;
    grid-column: 10/13;
  }
  .challenges {
    grid-row: 6/9;
    grid-column: 1/5;
  }
  .deliverables {
    grid-row: 6/9;
    grid-column: 5/9;
  }
  .competencies {
    grid-row: 6/9;
    grid-column: 9/13;
  }
  .resources {
    grid-row: 9/13;
    grid-column: 1/4;
  }
  .delegator {
    grid-row: 9/13;
    grid-column: 4/7;
  }
  .metrics {
    grid-row: 9/13;
    grid-column: 7/10;
  }
  .monitoring {
    grid-row: 9/13;
    grid-column: 10/13;
  }
}
</style>
