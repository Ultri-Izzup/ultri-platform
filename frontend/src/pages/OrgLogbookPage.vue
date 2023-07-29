<template>
  <q-page class="flex row fit">
    <q-card flat class="q-pa-xl">
      <q-card-section>

        <div v-for="[key, logbookEntry] in org.logbookEntries" :key="key">
          <div class="col">
            <div class="row text-caption">{{ Date(logbookEntry.createdAt).toLocaleString() }}</div>
            <div class="row" style="border-bottom: 1px solid lightgrey">{{ logbookEntry.note }}</div>
          </div>
        </div>

      </q-card-section>
    </q-card>
  </q-page>
</template>

<script setup>

import { useOrgStore } from "../stores/org";
import { useRoute } from "vue-router";

const route = useRoute();

const org = useOrgStore();

org.loadLogbookEntries(route.params.orgUid);

</script>

<style lang="scss">
.greyed {
  background-color: lightgray;
}
</style>
