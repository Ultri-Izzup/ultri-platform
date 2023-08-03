<template>
  <q-btn  flat dense icon="mdi-logout" class="gt-xs" @click="platformSignout"></q-btn>
</template>

<script setup language="ts">
import { useAuthStore } from '../../../stores/auth';
import {useRouter } from 'vue-router';

const auth = useAuthStore();
const router = useRouter();

const platformSignout = async() => {
  await auth.signOut();
  router.push('/')
}
</script>
