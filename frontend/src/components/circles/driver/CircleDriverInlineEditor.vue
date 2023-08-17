<template>
  <div class="row full-width">Driver UID: {{ circleDriversStore.drivers }}</div>
</template>

<script setup>

import { useCircleDriversStore } from "../../../stores/circleDrivers";

const props = defineProps({
  driverUid: String
})

const circleDriversStore = useCircleDriversStore();

</script>
