<template>
  <q-page class="flex row fit justify-center">
    <q-card flat class="q-pa-xl">
      <q-card-section>
        <div class="text-h3">Your Organizations</div>
      </q-card-section>
      <q-card-section>
        <div class="q-pa-md" style="max-width: 400px">
          <q-list>
            <q-item clickable :to="'/org/'+ org.uid" v-ripple v-for="[key, org]  in orgStore.orgs" :key="key">
              <q-item-section>
                <q-item-label>{{org.name}}</q-item-label>
                <q-item-label caption>{{org.uid}}</q-item-label>
              </q-item-section>
            </q-item>
          </q-list>
        </div>
      </q-card-section>
    </q-card>
  </q-page>
</template>

<script setup>
import { ref, watch, computed } from "vue";
import { useOrgStore } from "../stores/org";

const orgStore = useOrgStore();
orgStore.loadOrgs();
</script>

<style lang="scss">
</style>
