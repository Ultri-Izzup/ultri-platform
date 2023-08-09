<template>
  <div class="q-pa-xs">
    <div v-if="canvasName == 's3delegation'" class="full-width">
      The S3 Delegation Canvas by Bernhard Bockelbrink is licensed under a
      <a href="https://creativecommons.org/licenses/by-sa/4.0/"
        >Creative Commons Attribution-ShareAlike 4.0 International License</a
      >. Changes have been made to fit the space and purpose. More information on the S3 canvas series, and versions for printing the
      canvas in various formats can be found at <a href="http://s3canvas.sociocracy30.org">http://s3canvas.sociocracy30.org</a>
    </div>
    <div v-if="canvasName == 's3team'" class="full-width">
      The S3 Team Canvas by Bernhard Bockelbrink is licensed under a
      <a href="https://creativecommons.org/licenses/by-sa/4.0/"
        >Creative Commons Attribution-ShareAlike 4.0 International License</a
      >. Changes have been made to fit the space and purpose. More information on the S3 canvas series, and versions for printing the
      canvas in various formats can be found at <a href="http://s3canvas.sociocracy30.org">http://s3canvas.sociocracy30.org</a>
    </div>
    <div v-if="canvasName == 's3organization'" class="full-width">
      The S3 Organization Canvas by Bernhard Bockelbrink is licensed under a
      <a href="https://creativecommons.org/licenses/by-sa/4.0/"
        >Creative Commons Attribution-ShareAlike 4.0 International License</a
      >. Changes have been made to fit the space and purpose. More information on the S3 canvas series, and versions for printing the
      canvas in various formats can be found at <a href="http://s3canvas.sociocracy30.org">http://s3canvas.sociocracy30.org</a>
    </div>
    <div v-if="canvasName == 'lean'" class="full-width">

    </div>
    <div v-if="canvasName == 'coop'" class="full-width">

    </div>
    <div v-if="canvasName == 'business'" class="full-width">
      {{ $t('canvas.business.attribution')}}
    </div>
  </div>
</template>

<script setup>
import { computed } from "vue";
import { useRoute } from "vue-router";
const route = useRoute();
const canvasName = computed(() => route.params.canvasName);
</script>
