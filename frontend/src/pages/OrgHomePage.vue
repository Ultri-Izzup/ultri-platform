<template>
  <q-page class="row items-center justify-evenly" v-if="!auth.isSignedIn">
    <div class="text-h1 full-width text-center">{{ $t('homepage.heading') }}</div>
    <div class="text-h2 full-width  text-center">{{ $t('homepage.tagline') }}</div>
    <div class="full-width  text-center">
      <q-btn
        size="xl"
        :label="$t('homepage.button')"
        color="primary"
        @click="triggerSignInDialog"
      ></q-btn>
    </div>
  </q-page>
  <q-page class="row items-center justify-evenly" v-if="auth.isSignedIn">
    <div class="text-h1 full-width text-center">{{ $t('homepage.signedIn.heading') }}</div>
    <div class="text-h2 full-width  text-center">{{ $t('homepage.signedIn.tagline') }}</div>

  </q-page>
</template>

<script setup>

import { useAuthStore } from '../stores/auth';
const auth = useAuthStore();

const triggerSignInDialog = async () => {
  auth.setTargetUrl('/member');
  auth.setSignInRequired(true);
  console.log(auth.targetUrl)
}
</script>
