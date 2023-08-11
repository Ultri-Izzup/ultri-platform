<template>
  <div class="col">
    <q-card>
        <q-toolbar :class="colorStore.darkMode ? 'bg-grey-9' : ' bg-primary ' + ' text-white '">
          <q-toolbar-title>{{ $t("circles.circleMembers") }}</q-toolbar-title>
          <q-btn
            v-if="Screen.lt.md"
            @click="showContent = !showContent"
            dense
            :icon="showContent ? 'mdi-chevron-up' : 'mdi-chevron-down'"
            :class="colorStore.darkMode ? 'bg-dark q-mr-sm' : 'bg-white text-primary q-mr-sm'"
          />
          <q-btn
            @click="circleMembersStore.triggerNewCircleMemberDialog()"
            dense
            icon="mdi-plus"
            :class="colorStore.darkMode ? 'bg-dark' : 'bg-white text-primary'"
          />
        </q-toolbar>
        <q-card-section v-if="circleMembersStore.hasMembers && (showContent || Screen.gt.sm) ">
          <q-list>

            <q-item v-for="member in circleMembersStore.members" :key="member.uid">
              <q-item-section class="overflow-hidden">
                <div class="row">
                <q-item-label>{{ member.name }}</q-item-label> <q-space /><q-btn @click="circleMembersStore.deleteMember(member.uid)" icon="mdi-delete" flat size="sm" class="q-px-xs" />
                </div>
                <div class="row">
                <q-item-label caption>{{ member.email }}</q-item-label>
                </div>
              </q-item-section>
            </q-item>
          </q-list>
        </q-card-section>
        <q-card-section v-if="!circleMembersStore.hasMembers" class="text-center justify-center">
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
import { ref } from "vue";
import { useCircleMembersStore } from "../../stores/circleMembers";
import { useColorStore } from "../../stores/color";

import { Screen } from "quasar";

import CircleMemberDialog from "./dialog/CircleMemberDialog.vue";

const circleMembersStore = useCircleMembersStore();
const colorStore = useColorStore();

const showContent = ref(true);


</script>

<style lang="scss"></style>
