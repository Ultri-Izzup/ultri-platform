<template>
  <div>
    <q-toolbar class="bg-primary text-white shadow-2">
      <q-toolbar-title>Welcome to Ultri</q-toolbar-title>
    </q-toolbar>
    <q-card flat>
      <q-card-section>
        <p class="q-px-md q-pt-md text-bold">We are a software collective that builds open source tools.</p><p class="q-px-md">We created OpenSociocracy.org to help guide our internal tools built around Sociocracy. Those same tools and others are used here, to provide a better startup experience.</p>
        <p class="q-px-md">We will be releasing new startup tools here weekly, so check back often.</p>
        <p class="q-px-md">If you would like to help shape the product, join our Discord.</p>
      </q-card-section>
      <q-card-actions class="justify-center">
        <q-btn label="Discord" color="primary" href="https://discord.gg/jaJ3v6Zx"></q-btn>
      </q-card-actions>
    </q-card>
    <q-card flat>
      <q-card-section>
        <p class="q-px-md q-pt-md text-bold">Planning Calendar</p>
        <p class="q-px-md">All of our planning meetings are open, and we welcome attendance.</p>
      </q-card-section>
      <q-card-actions class="justify-center">
        <q-btn label="Calendar" color="secondary" to="/calendar"></q-btn>
      </q-card-actions>
    </q-card>
  </div>
</template>

<script setup>
import { useRoute } from "vue-router";
const route = useRoute();

</script>

<style lang="scss"></style>
