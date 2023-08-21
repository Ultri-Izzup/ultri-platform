<template>
  <div>
    <q-toolbar class="bg-primary text-white shadow-2">
      <q-btn
        flat
        icon="mdi-arrow-left"
        size="md"
        v-if="orgUid"
        no-caps
        clickable
        :to="{ name: 'orgDashboard', params: { orgUid: orgUid } }"
        ><q-toolbar-title>Ultri - Canava</q-toolbar-title></q-btn
      ><q-toolbar-title v-if="!orgUid">Ultri - Canava</q-toolbar-title>
    </q-toolbar>
    <q-list>
      <q-item
        clickable
        v-ripple
      >
        <q-item-section label>
          <q-item-label class="text-bold"
            >Custom Canvas</q-item-label
          >
        </q-item-section>
      </q-item>
      <q-separator></q-separator>
    </q-list>
  </div>
</template>

<script setup>

</script>

<style lang="scss"></style>
