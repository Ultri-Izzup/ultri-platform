<template>
<div class="row"  :style="'height: '+ height +'%'">
  <slot />
</div>
</template>
  
<script setup>
const props = defineProps({
  height: String
})

</script>
  