<template>
  <div class="col">
    <q-card>
        <q-toolbar :class="colorStore.darkMode ? 'bg-grey-9' : ' bg-primary ' + ' text-white '">
          <q-toolbar-title>{{ $t("circles.circleMembers") }}</q-toolbar-title>
          <q-btn
            @click="circleMembersStore.triggerNewCircleMemberDialog()"
            dense
            icon="mdi-plus"
            :class="colorStore.darkMode ? 'bg-dark' : 'bg-white text-primary'"
          />
        </q-toolbar>
        <q-card-section v-if="circleMembersStore.hasCircleMembers">

          Display Member {{ circleMembersStore.members}}
        </q-card-section>
        <q-card-section v-else class="text-center justify-center">
          <q-btn
            :label="$t('circles.addMember')"
            color="primary"
            @click="circleMembersStore.triggerNewCircleMemberDialog()"
          >
          </q-btn>
        </q-card-section>
    </q-card>

    <CircleMemberDialog v-model="circleMembersStore.showNewCircleMemberDialog"></CircleMemberDialog>
  </div>
</template>

<script setup>

import { useCircleMembersStore } from "../../stores/circleMembers";
import { useColorStore } from "../../stores/color";


import CircleMemberDialog from "./dialog/CircleMemberDialog.vue";

const circleMembersStore = useCircleMembersStore();
const colorStore = useColorStore();


</script>

<style lang="scss"></style>
