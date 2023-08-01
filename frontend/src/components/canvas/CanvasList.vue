<template>
  <div>
  <ul>
    <li><router-link :to="{ name: 'canvasPage', params: { canvasName: 'business' }}">{{ $t('canvas.business.name', 'Business') }}</router-link></li>
    <li><router-link :to="{ name: 'canvasPage', params: { canvasName: 'coop' }}">{{ $t('canvas.coop.name', 'Co-op Ownership') }}</router-link></li>
    <li><router-link :to="{ name: 'canvasPage', params: { canvasName: 's3' }}">{{ $t('canvas.s3.name', 'S3') }}</router-link></li>
  </ul>
  </div>
</template>

<script setup>


</script>
