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
const { t } = useI18n();
const canvasDef=[{
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 1,
  },{
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 2,
  },{
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 3,
  },{
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 4,
  },{
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 5,
  },{
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 6,
  },{
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 7,
  },{
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 8,
  },{
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 9,
  },{
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 10,
  },{
    title: t("canvas.business.partners.title"),
    instructions: t("canvas.business.partners.instructions"),
    class: "key-partners",
    sectionKey: "partners",
    id: 11,
  }]</script>