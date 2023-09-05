<template>
  <q-btn  flat dense icon="mdi-logout" class="gt-xs" @click="platformSignOut"></q-btn>
</template>

<script setup language="ts">
import { useAuthStore } from '../../../stores/auth';
import { useCanavaStore } from '../../../stores/canava';
import {useRouter } from 'vue-router';

const auth = useAuthStore();
const canavaStore = useCanavaStore();
const router = useRouter();

const platformSignOut = async() => {
  await auth.signOut();
  canavaStore.$reset();
  router.push('/')
}
</script>
