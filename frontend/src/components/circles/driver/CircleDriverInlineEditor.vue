<template>
  <div class="row full-width">
    <q-card class="full-width">
      <q-card-section class="text-body1 text-bold">
        <contenteditable
          tag="div"
          :contenteditable="true"
          v-model="circleDriversStore.getDriverByUid(props.driverUid).label"
          :no-nl="true"
          :no-html="true"
          @returned="enterPressed"
        />
      </q-card-section>
      <q-card-section>
        <contenteditable
          tag="div"
          :contenteditable="true"
          v-model="circleDriversStore.getDriverByUid(props.driverUid).description"
          :no-nl="true"
          :no-html="true"
          @returned="enterPressed"
        />
      </q-card-section>
      <q-card-actions>
        <q-space />
        <q-toggle  v-model="circleDriversStore.getDriverByUid(props.driverUid).internal" :label="$t('circles.dialog.drivers.internal')"></q-toggle>
        <q-space />
        <q-btn @click="emit('unlink')" :label="$t('circles.drivers.removeLink')" color="secondary" />
        <q-space />
      </q-card-actions>
    </q-card>
    <div class="row full-width"></div>
  </div>
</template>

<script setup>
import contenteditable from "vue-contenteditable"; // Not needed it registered globally
import { useCircleDriversStore } from "../../../stores/circleDrivers";

const props = defineProps({
  driverUid: String,
});

const emit = defineEmits(['unlink'])

const enterPressed = () => {};

const circleDriversStore = useCircleDriversStore();

</script>
