<template>
  <div class="col">
    <q-card>
      <q-toolbar
        :class="
          colorStore.darkMode ? 'bg-grey-9' : ' bg-primary ' + ' text-white '
        "
      >
        <q-toolbar-title>{{ $t("circles.circleMembers") }}</q-toolbar-title>
        <q-btn
          v-if="Screen.lt.md"
          @click="showContent = !showContent"
          dense
          :icon="showContent ? 'mdi-chevron-up' : 'mdi-chevron-down'"
          :class="
            colorStore.darkMode
              ? 'bg-dark q-mr-sm'
              : 'bg-white text-primary q-mr-sm'
          "
          size="sm"
        />
        <q-btn
          @click="circleMembersStore.triggerNewCircleMemberDialog()"
          dense
          icon="mdi-plus"
          :class="colorStore.darkMode ? 'bg-dark' : 'bg-white text-primary'"
          size="sm"
        />
      </q-toolbar>
      <q-card-section
        v-if="circleMembersStore.hasMembers && (showContent || Screen.gt.sm)"
        class="q-pa-xs"
      >
        <q-list>
          <q-separator />
          <div v-for="member in circleMembersStore.sortMembers" :key="member.uid">
            <q-item>
              <q-item-section class="overflow-hidden">
                <div class="row">
                  <q-item-label>
                    <contenteditable
                      tag="div"
                      :contenteditable="true"
                      v-model="member.name"
                      :no-nl="true"
                      :no-html="true"
                      @returned="enterPressed"
                    />
                  </q-item-label>
                </div>
                <q-item-label caption>
                  <contenteditable
                    tag="div"
                    :contenteditable="true"
                    v-model="member.email"
                    :no-nl="true"
                    :no-html="true"
                    @returned="enterPressed"
                  />
                </q-item-label>
              </q-item-section>
              <q-item-section side >
                <q-btn
                    @click="deleteMember(member.uid)"
                    icon="mdi-delete"
                    flat
                    size="sm"
                    class="q-pa-xs"
                  />
              </q-item-section>
            </q-item>
            <q-separator />
          </div>
        </q-list>
      </q-card-section>
      <q-card-section
        v-if="!circleMembersStore.hasMembers"
        class="text-center justify-center"
      >
        <q-btn
          :label="$t('circles.addMember')"
          color="primary"
          @click="circleMembersStore.triggerNewCircleMemberDialog()"
        >
        </q-btn>
      </q-card-section>
    </q-card>

    <CircleMemberDialog
      v-model="circleMembersStore.showNewCircleMemberDialog"
    ></CircleMemberDialog>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useCircleMembersStore } from "../../stores/circleMembers";
import { useCirclesStore } from "../../stores/circles";
import { useColorStore } from "../../stores/color";
import contenteditable from "vue-contenteditable"; // Not needed it registered globally

import { Screen } from "quasar";

import CircleMemberDialog from "./dialog/CircleMemberDialog.vue";

const enterPressed = () => {

}
const circleMembersStore = useCircleMembersStore();
const circlesStore = useCirclesStore();
const colorStore = useColorStore();

const showContent = ref(true);

const deleteMember = (memberUid) => {
  circleMembersStore.deleteMember(memberUid);
  circlesStore.deleteMembers([memberUid]);
}
</script>

<style lang="scss"></style>
