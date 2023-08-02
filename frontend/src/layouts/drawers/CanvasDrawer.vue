<template>
  <div>
    <q-toolbar class="bg-primary text-white shadow-2">
      <q-toolbar-title>Ultri Co-op</q-toolbar-title>
    </q-toolbar>
    <q-list>
      <q-item clickable v-ripple to="/canvas/business">
        <q-item-section>
          <q-item-label>Business Canvas</q-item-label>
        </q-item-section>
      </q-item>

      <q-item clickable v-ripple to="/canvas/coop">
        <q-item-section>
          <q-item-label>Co-op Ownership Canvas</q-item-label>
        </q-item-section>
      </q-item>

      <q-item clickable v-ripple to="/canvas/s3">
        <q-item-section>
          <q-item-label>S3 Organization Canvas</q-item-label>
        </q-item-section>
      </q-item>

    </q-list>
  </div>
</template>

<script setup></script>

<style lang="scss"></style>
