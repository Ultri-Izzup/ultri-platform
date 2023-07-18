<template>
  <q-page class="flex row fit justify-center">
    <q-card class="q-pa-xl">
      <q-card-section>
        <div class="text-h3">Organizations</div>
      </q-card-section>
      <q-card-section>
        <div class="text-h5">
          Organizations provide a unique set of members with roles specific to
          the organization.
        </div>
      </q-card-section>
    </q-card>
  </q-page>
</template>

<script setup>
import { ref, watch, computed } from "vue";
import { useOrgStore } from "../stores/org";

const org = useOrgStore();
org.loadOrgs();
console.log(org.orgs)


</script>

<style lang="scss">
</style>
