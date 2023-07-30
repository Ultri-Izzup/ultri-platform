<template>
  <q-card v-for="item in data" :key="item.id" :class="item.class">
    <q-card-section class="sticky-title">
      <p>{{ item.title }}</p>
      <q-separator></q-separator>
    </q-card-section>
  </q-card>
</template>
<script setup>
const props = defineProps({
  data: Object,
});
</script>
