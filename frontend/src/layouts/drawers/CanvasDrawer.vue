<template>
  <div>
    <q-toolbar class="bg-primary text-white shadow-2">
      <q-btn flat icon="mdi-arrow-left" size="md" v-if="orgUid" no-caps clickable :to="{ name: 'orgDashboard', params: { orgUid: orgUid }}"><q-toolbar-title>Ultri - Canvas</q-toolbar-title></q-btn><q-toolbar-title v-if="!orgUid">Ultri - Canvas</q-toolbar-title>
    </q-toolbar>
    <q-list>
      <q-item clickable v-ripple :to="{ name: toRoute, params: { canvasName: 'business' }}">
        <q-item-section label>
          <q-item-label class="text-bold">Business Model Canvas</q-item-label>
        </q-item-section>
      </q-item>
      <q-separator></q-separator>

      <q-item clickable v-ripple :to="{ name: toRoute, params: { canvasName: 's3-organization' }}">
        <q-item-section>
          <q-item-label class="text-bold">S3 Organization Canvas</q-item-label>
        </q-item-section>

      </q-item>
      <q-separator></q-separator>

      <q-item clickable v-ripple :to="{ name: toRoute, params: { canvasName: 's3-delegation' }}">
        <q-item-section>
          <q-item-label class="text-bold">S3 Delegation Canvas</q-item-label>
        </q-item-section>
      </q-item>
      <q-separator></q-separator>

      <q-item clickable v-ripple :to="{ name: toRoute, params: { canvasName: 's3-team' }}">
        <q-item-section>
          <q-item-label class="text-bold">S3 Team Canvas</q-item-label>
        </q-item-section>
      </q-item>
      <q-separator></q-separator>

      <q-item clickable v-ripple :to="{ name: toRoute, params: { canvasName: 'coop' }}">
        <q-item-section>
          <q-item-label class="text-bold">Co-op Ownership Canvas</q-item-label>
        </q-item-section>
      </q-item>
      <q-separator></q-separator>

      <q-item clickable v-ripple :to="{ name: toRoute, params: { canvasName: 'lean' }}">
        <q-item-section>
          <q-item-label class="text-bold">Lean Canvas</q-item-label>
        </q-item-section>
      </q-item>
      <q-separator></q-separator>

    </q-list>
  </div>
</template>

<script setup>
import { ref } from"vue";
import { useRoute } from "vue-router";
const route = useRoute();

const orgUid = route.params.orgUid;

const toRoute = ref('canvasPage');

if(orgUid) {
  toRoute.value = 'orgCanvasPage'
}

</script>

<style lang="scss"></style>
