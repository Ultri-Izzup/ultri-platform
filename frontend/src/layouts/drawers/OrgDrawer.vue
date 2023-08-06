<template>
  <div>
    <q-list>
      <!-- CURRENT ORG / SELECT ORG-->
      <q-expansion-item
        bordered
        expand-separator
        icon="mdi-office-building"
        :label="
          org.currentOrgUid && org.orgs.get(org.currentOrgUid)
            ? org.orgs.get(org.currentOrgUid).name
            : $t('orgs.drawer.selectOrganization')
        "
        header-class="text-weight-bolder"
        :caption="
          org.currentOrgUid
            ? $t('orgs.drawer.currentOrganization')
            : $t('orgs.drawer.selectOrCreateAnOrganization')
        "
      >
        <!-- ADD ORGANIZATION -->
        <q-item clickable @click="org.triggerOrgCreateDialog">
          <q-item-section avatar>
            <q-icon name="mdi-office-building-plus" />
          </q-item-section>
          <q-item-section>
            <q-item-label>{{ $t("orgs.newOrg") }}</q-item-label>
            <q-item-label caption>
              {{ $t("orgs.createAnOrg") }}
            </q-item-label>
          </q-item-section>
        </q-item>

        <!-- LIST ORGANIZATIONS -->
        <q-item header dense v-if="org.orgs.size > 0">
          <div class="text-center full-width text-bold text-italic">
            {{ $t("orgs.drawer.currentOrganizations") }}
          </div>
        </q-item>
        <q-expansion-item
          v-for="[ix, item] in org.orgs"
          :key="ix"
          expand-icon-toggle
          expand-separator
          :label="item.name"
          :caption="item.uid"
          :to="'/org/' + item.uid"
        >
          {{ item }}
          <!-- ORGANIZATION QUICKVIEW -->
          <q-card>
            <q-card-actions>
              <!-- ORGANIZATION QUICKVIEW CONTROLS -->
              <q-btn
                flat
                icon="mdi-delete"
                size="sm"
                @click="deleteOrg(item.uid)"
                >{{ $t("nav.delete") }}</q-btn
              >
            </q-card-actions>
          </q-card>
        </q-expansion-item>
      </q-expansion-item>
    </q-list>
    <!-- ORGANIZATION MANAGEMENT MENU -->
    <q-list v-if="org.currentOrgUid" bordered>
      <!-- DEFINE ORG -->
      <q-expansion-item
        expand-separator
        icon="mdi-office-building-cog"
        :label="$t('orgs.drawer.defineOrgLabel')"
        :caption="$t('orgs.drawer.defineOrgCaption')"
        group="top-level"
        header-class="text-weight-bolder"
      >
        <!-- MISSION STATEMENT -->
        <q-expansion-item
          expand-separator
          icon="mdi-script-text"
          :label="$t('orgs.drawer.missionStatementLabel')"
          :caption="$t('orgs.drawer.missionStatementCaption')"
          group="org-management"
          header-class="text-weight-medium"
        >
          <div v-if="org.nuggetUid">Org Nugget Exists</div>
          <div v-else class="text-center justify-center q-py-md">
            <q-btn
              label="Define Mission"
              @click="org.triggerOrgMissionDialog"
            ></q-btn>
          </div>
        </q-expansion-item>

        <!-- CANVAS -->
        <q-item clickable :to="'/org/' + org.currentOrgUid + '/canvas'">
          <q-item-section avatar>
            <q-icon name="mdi-artboard" />
          </q-item-section>
          <q-item-section>
            <q-item-label class="text-weight-medium">{{
              $t("orgs.drawer.canvasesLabel")
            }}</q-item-label>
            <q-item-label caption>
              {{ $t("orgs.drawer.canvasesCaption") }}
            </q-item-label>
          </q-item-section>
        </q-item>
      </q-expansion-item>

      <!-- CIRCLES -->
      <q-separator></q-separator>
      <q-item clickable :to="{ name: 'orgCircles', params: { orgUid: route.params.orgUid } }">
        <q-item-section avatar>
          <q-icon name="mdi-domain" />
        </q-item-section>
        <q-item-section>
          <q-item-label  class="text-weight-bolder">{{ $t('orgs.drawer.circlesLabel') }}</q-item-label>
          <q-item-label caption>
            {{ $t('orgs.drawer.circlesCaption') }}
          </q-item-label>
        </q-item-section>
      </q-item>

       <!-- MEMBERS -->
       <q-separator></q-separator>
       <q-item clickable :to="{ name: 'orgMembers', params: { orgUid: route.params.orgUid } }">
        <q-item-section avatar>
          <q-icon name="mdi-account-multiple" />
        </q-item-section>
        <q-item-section>
          <q-item-label  class="text-weight-bolder">{{ $t('orgs.drawer.membersLabel') }}</q-item-label>
          <q-item-label caption>
            {{ $t('orgs.drawer.membersCaption') }}
          </q-item-label>
        </q-item-section>
      </q-item>

      <!-- LOGBOOK -->
      <q-separator></q-separator>
      <q-item clickable :to="'/org/' + org.currentOrgUid + '/logbook'">
        <q-item-section avatar>
          <q-icon name="mdi-book-cog" />
        </q-item-section>
        <q-item-section>
          <q-item-label class="text-weight-bolder">{{
            $t("orgs.drawer.logbookLabel")
          }}</q-item-label>
          <q-item-label caption>
            {{ $t("orgs.drawer.logbookDashboardCaption") }}
          </q-item-label>
        </q-item-section>
      </q-item>
    </q-list>
  </div>
</template>

<script setup>
import { ref, watch, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { useQuasar } from "quasar";
import { useAuthStore } from "../../stores/auth";
import { useOrgStore } from "../../stores/org";
import { useColorStore } from "../../stores/color";

const route = useRoute();
const router = useRouter();
const auth = useAuthStore();
const color = useColorStore();
const org = useOrgStore();

const deleteOrg = (uid) => {
  org.deleteMemberOrg(uid);

  if (uid == org.currentOrgUid) {
    router.push("/orgs");
  }
};
</script>

<style lang="scss">
</style>
