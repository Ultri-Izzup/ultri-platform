<template>
  <div>
  <ul>
    <li><router-link :to="{ name: toRoute, params: { canvasName: 'business' }}">{{ $t('canvas.business.name', 'Business') }}</router-link></li>
    <li><router-link :to="{ name: toRoute, params: { canvasName: 'coop' }}">{{ $t('canvas.coop.name', 'Co-op Ownership') }}</router-link></li>
    <li><router-link :to="{ name: toRoute, params: { canvasName: 's3' }}">{{ $t('canvas.s3.name', 'S3') }}</router-link></li>
  </ul>
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
