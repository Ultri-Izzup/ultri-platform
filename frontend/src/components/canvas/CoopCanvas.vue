<template>
  <q-page class="flex flex-center"
    ><q-card
      ><q-card-section class="q-pa-xl"
        ><div class="text-h2"> Co-op Ownership Canvas</div><div class="text-h2">coming soon...</div></q-card-section
      ></q-card
    ></q-page
  >
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
    instructions: t("canvas.s3.coop.stakeholders.instructions"),
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
    class: "benfits",
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
