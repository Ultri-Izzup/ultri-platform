<template>
  <q-page>
    Member Management
    <ul>
      <li>List Members</li>
      <li>List Sent Invites</li>
      <li>Invite Members</li>
      <li>We need name, email and optionally circles</li>
    </ul>
  </q-page>
</template>

<script setup>
import VueMarkdown from "vue-markdown-render";

import { useAuthStore } from "../stores/auth";
const auth = useAuthStore();

const triggerSignInDialog = async () => {
  auth.setTargetUrl("/member");
  auth.setSignInRequired(true);
  console.log(auth.targetUrl);
};
</script>
