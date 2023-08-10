<template>
  <q-page class="container q-pa-md">
    <CanvasSection
      v-for="info in canvasDef"
      :info="info"
      canvasName="coop"
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
    title: t("canvas.coop.purpose.title"),
    instructions: t("canvas.coop.purpose.instructions"),
    class: "purpose",
    sectionKey: "purpose",
    id: 1,
  },
  {
    title: t("canvas.coop.stakeholders.title"),
    instructions: t("canvas.coop.stakeholders.instructions"),
    class: "stakeholders",
    sectionKey: "stakeholders",
    id: 2,
  },
  {
    title: t("canvas.coop.nonOwnerStakeholders.title"),
    instructions: t("canvas.coop.nonOwnerStakeholders.instructions"),
    class: "nonOwnerStakeholders",
    sectionKey: "nonOwnerStakeholders",
    id: 3,
  },
  {
    title: t("canvas.coop.benefits.title"),
    instructions: t("canvas.coop.benefits.instructions"),
    class: "benefits",
    sectionKey: "benefits",
    id: 4,
  },
  {
    title: t("canvas.coop.responsibilities.title"),
    instructions: t("canvas.coop.responsibilities.instructions"),
    class: "responsibilities",
    sectionKey: "responsibilities",
    id: 5,
  },
  {
    title: t("canvas.coop.guidance.title"),
    instructions: t("canvas.coop.guidance.instructions"),
    class: "guidance",
    sectionKey: "guidance",
    id: 6,
  },
  {
    title: t("canvas.coop.governance.title"),
    instructions: t("canvas.coop.governance.instructions"),
    class: "governance",
    sectionKey: "governance",
    id: 7,
  },
  {
    title: t("canvas.coop.financial.title"),
    instructions: t("canvas.coop.financial.instructions"),
    class: "financial",
    sectionKey: "financial",
    id: 8,
  },
  {
    title: t("canvas.coop.investment.title"),
    instructions: t("canvas.coop.investment.instructions"),
    class: "investment",
    sectionKey: "investment",
    id: 9,
  },
];
</script>
<style scoped>
.container {
  display: grid;
}
@media screen and (min-width: 864px) {
  .container {
    grid-template-columns: repeat(5, 1fr);
    grid-template-rows: repeat(6, 1fr);
    height: 90vh;
    gap: 10px;
  }
  .purpose {
    grid-column: 1/6;
    grid-row: 1/2;
  }
  .stakeholders {
    grid-column: 1/2;
    grid-row: 2/4;
  }
  .nonOwnerStakeholders {
    grid-column: 1/2;
    grid-row: 4/6;
  }
  .benefits {
    grid-column: 2/3;
    grid-row: 2/6;
  }
  .responsibilities {
    grid-column: 3/4;
    grid-row: 2/6;
  }
  .guidance {
    grid-row: 2/6;
    grid-column: 4/5;
  }
  .governance {
    grid-row: 2/6;
    grid-column: 5/6;
  }
  .financial {
    grid-column: 1/3;
    grid-row: 6/7;
  }
  .investment {
    grid-column: 3/6;
    grid-row: 6/7;
  }
}
</style>
