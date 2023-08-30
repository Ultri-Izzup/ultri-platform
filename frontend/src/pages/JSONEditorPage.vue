<template>
  <q-page class="flex row justify-center">
    <div class="text-h2 row full-width justify-center text-center text-bold text-primary">
      Ultri Platform
    </div>

    <q-card flat :style="Screen.lt.md ? 'width: 100%' : 'width: 80%'">
      <q-tabs
        v-model="tab"
        dense
        class="text-grey"
        active-color="primary"
        indicator-color="primary"
        align="justify"
        narrow-indicator
      >
        <q-tab name="overview" label="Overview"></q-tab>
        <q-tab name="stack" label="Stack"></q-tab>
        <q-tab name="model" label="Model"></q-tab>
        <q-tab name="api" label="API"></q-tab>
        <q-tab name="frontend" label="Frontend"></q-tab>
      </q-tabs>

      <q-separator></q-separator>

      <q-tab-panels v-model="tab" animated>
        <q-tab-panel name="overview">

          <q-card-section>
            <div class="text-h4 text-bold text-primary">Overview</div>
          </q-card-section>
          <q-card-section class="text-body1 text-grey-9">
              The platform used to run the Ultri.com website is available as an
              open source project. You are free to use it for your private and
              public needs, subject to the open source licensing.
          </q-card-section>

          <q-card-section>
            <div class="text-h6 text-bold text-primary">Tech Stack</div>
          </q-card-section>
          <q-card-section class="text-body1 text-grey-9">
              We purposefully keep our stack simple to maximize the ability for someone to self-host and self-support the platform. That doesn't mean we compromised on performance or scalability.
          </q-card-section>

          <q-card-section>
            <div class="text-h6 text-bold text-primary">Data Model</div>
          </q-card-section>
          <q-card-section class="text-body1 text-grey-9">
              The data model is optimized to work with the tech stack and our application flow. Again, we keep things simple where possible to make support and customization safe and easy.
          </q-card-section>

          <q-card-section>
            <div class="text-h6 text-bold text-primary">API Spec</div>
          </q-card-section>
          <q-card-section class="text-body1 text-grey-9">
              The API spec is a straight-forward REST model, coupled with optimized, custom API and dat6abase calls where needed.
          </q-card-section>

          <q-card-section>
            <div class="text-h6 text-bold text-primary">Frontend UI</div>
          </q-card-section>
          <q-card-section class="text-body1 text-grey-9">
              The front end website is a single page app (SPA). It is written in JavaScript using Vue 3 and Quasar. It is localized and can easily be customized for your own deployments.
          </q-card-section>


        </q-tab-panel>

        <q-tab-panel name="stack">
          <div class="text-h6">Tech Stack</div>
          <TechStackDiagram />
        </q-tab-panel>

        <q-tab-panel name="model">
          <div class="text-h6">Data Model</div>
          Data model.
        </q-tab-panel>

        <q-tab-panel name="api">
          <div class="text-h6">API Spec</div>
          API intro
        </q-tab-panel>

        <q-tab-panel name="frontend">
          <div class="text-h6">Frontend</div>
          Frontend
        </q-tab-panel>
      </q-tab-panels>
    </q-card>
  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { Screen } from "quasar";

import TechStackDiagram from "../components/platform/TechStackDiagram.vue"

const tab = ref("overview");

const data = [
  {
    id: "mission",
    text: "Mission",
    next: ["general"],
    edgeType: "circle",
    link: "-- Brian --->",
  },
  {
    id: "general",
    text: "General",
    edgeType: "circle",
    next: ["mission"],
    link: "-. Gail .->",
  },
  {
    id: "general",
    text: "General",
    edgeType: "circle",
    next: ["product"],
    link: "-- Tom --->",
  },
  {
    id: "general",
    text: "General",
    edgeType: "circle",
    next: ["tech"],
    link: "-- Geoff --->",
  },
  {
    id: "product",
    text: "Product",
    edgeType: "circle",
    next: ["general"],
    link: "-. Ted .->",
  },
  { id: "product", text: "Product", edgeType: "circle" },
  {
    id: "tech",
    text: "Tech",
    edgeType: "circle",
    next: ["general"],
    link: "-. Rae .->",
  },
  { id: "tech", text: "Tech", edgeType: "circle" },
  // { id: "3", text: "C", link:"----", next: ["4", "6"] },
  // { id: "4", text: "D", link: "-- This is the text ---", next: ["5"] },
  // { id: "5", text: "E" },
  // { id: "6", text: "F" },
];

const editNode = (nodeId) => {
  alert(nodeId);
};
</script>
<style></style>
