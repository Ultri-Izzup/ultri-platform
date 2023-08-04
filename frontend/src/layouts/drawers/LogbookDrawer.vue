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
            <q-btn label="Define Mission" @click="org.triggerOrgMissionDialog"></q-btn>
          </div>
        </q-expansion-item>

        <!-- DRIVERS -->
        <q-expansion-item
          expand-separator
          icon="mdi-sign-direction"
          :label="$t('orgs.drawer.driversLabel')"
          :caption="$t('orgs.drawer.driversCaption')"
          group="org-management"
          header-class="text-weight-medium"
        >
          <!-- ADD DRIVER -->
          <q-item clickable @click="org.triggerNewDriverDialog">
            <q-item-section avatar>
              <q-icon name="mdi-sign-direction-plus" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{
                $t("orgs.drawer.newDriverLabel")
              }}</q-item-label>
              <q-item-label caption>
                {{ $t("orgs.drawer.newDriverCaption") }}
              </q-item-label>
            </q-item-section>
          </q-item>

          <!-- LIST DRIVERS -->
          <q-expansion-item
            v-for="[ix, item] in org.$state.orgDrivers"
            :key="ix"
            expand-icon-toggle
            expand-separator
            :label="item.name"
            :caption="item.uid"
            :to="'/org/' + item.uid"
          >
            <!-- DRIVER QUICKVIEW -->
            <q-card>
              <q-card-actions>
                <!-- DRIVER QUICKVIEW CONTROLS -->
                <q-btn
                  flat
                  icon="mdi-delete"
                  size="sm"
                  @click="org.delete(item.uid)"
                  >{{ $t("nav.delete") }}</q-btn
                >
              </q-card-actions>
            </q-card>
          </q-expansion-item>

          <!-- DRIVER DASHBOARD - BROWSE DRIVERS -->
          <q-item clickable :to="'/org/' + org.currentOrgUid + '/members'">
            <q-item-section avatar>
              <q-icon name="mdi-view-dashboard-variant" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{
                $t("orgs.drawer.driversDashboardLabel")
              }}</q-item-label>
              <q-item-label caption>
                {{ $t("orgs.drawer.driversDashboardCaption") }}
              </q-item-label>
            </q-item-section>
          </q-item>
        </q-expansion-item>

                <!-- OKR -->
                <q-expansion-item
          expand-separator
          icon="mdi-checkbook"
          :label="$t('orgs.drawer.okrLabel')"
          :caption="$t('orgs.drawer.okrCaption')"
          group="org-management"
          header-class="text-weight-medium"
        >
          OKR - List of Objectives, that expand to show key results
          <!-- LIST OBJECTIVES -->
          <q-expansion-item
            v-for="[ix, item] in org.$state.orgMembers"
            :key="ix"
            expand-icon-toggle
            expand-separator
            :label="item.name"
            :caption="item.uid"
            :to="'/org/' + org.currentOrgUid + '/member/' + item.uid"
          >
            <!-- KEY RESULTS -->
            <q-card>
              <q-card-actions>
                <!-- OBJECTIVE CONTROLS -->
                <q-btn
                  flat
                  icon="mdi-delete"
                  size="sm"
                  @click="org.deleteMemberOrg(item.uid)"
                  >{{ $t("nav.delete") }}</q-btn
                >
              </q-card-actions>
            </q-card>
          </q-expansion-item>
        </q-expansion-item>

        <!-- DOMAINS -->
        <q-expansion-item
          expand-separator
          icon="mdi-domain"
          :label="$t('orgs.drawer.domainsLabel')"
          :caption="$t('orgs.drawer.domainsCaption')"
          group="org-management"
          header-class="text-weight-medium"
        >
          <!-- ADD DOMAIN -->
          <q-item clickable @click="org.triggerNewDomainDialog">
            <q-item-section avatar>
              <q-icon name="mdi-domain" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{
                $t("orgs.drawer.newDomainLabel")
              }}</q-item-label>
              <q-item-label caption>
                {{ $t("orgs.drawer.newDomainCaption") }}
              </q-item-label>
            </q-item-section>
          </q-item>
          <!-- LIST DOMAINS -->
          <q-expansion-item
            v-for="[ix, item] in org.$state.orgDomains"
            :key="ix"
            expand-icon-toggle
            expand-separator
            :label="item.name"
            :caption="item.uid"
            :to="'/org/' + org.currentOrgUid + '/domain/' + item.uid"
          >
            <!-- DOMAIN QUICKVIEW -->
            <q-card>
              <q-card-actions>
                <!-- DOMAIN QUICKVIEW CONTROLS -->
                <q-btn
                  flat
                  icon="mdi-delete"
                  size="sm"
                  @click="org.delete(item.uid)"
                  >{{ $t("nav.delete") }}</q-btn
                >
              </q-card-actions>
            </q-card>
          </q-expansion-item>
          <!-- DOMAIN DASHBOARD - BROWSE DOMAINS -->
          <q-item clickable :to="'/org/' + org.currentOrgUid + '/members'">
            <q-item-section avatar>
              <q-icon name="mdi-view-dashboard" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{
                $t("orgs.drawer.domainsDashboardLabel")
              }}</q-item-label>
              <q-item-label caption>
                {{ $t("orgs.drawer.domainsDashboardCaption") }}
              </q-item-label>
            </q-item-section>
          </q-item>
        </q-expansion-item>

        <!-- CANVAS -->
        <q-item clickable :to="'/org/' + org.currentOrgUid + '/canvas'">
        <q-item-section avatar>
          <q-icon name="mdi-artboard" />
        </q-item-section>
        <q-item-section>
          <q-item-label class="text-weight-medium">{{ $t('orgs.drawer.canvasesLabel') }}</q-item-label>
          <q-item-label caption>
            {{ $t('orgs.drawer.canvasesCaption') }}
          </q-item-label>
        </q-item-section>
      </q-item>
      </q-expansion-item>

      <!-- METRICS -->
      <!--<q-expansion-item
          expand-separator
          icon="mdi-chart-bar-stacked"
          :label="$t('orgs.drawer.metricsLabel')"
          :caption="$t('orgs.drawer.metricsCaption')"
          group="top-level"
          header-class="text-weight-medium"
        >
          Display the top internal metrics about org, related to cost and usage.

          <q-expansion-item
            v-for="[ix, item] in org.$state.orgMembers"
            :key="ix"
            expand-icon-toggle
            expand-separator
            :label="item.name"
            :caption="item.uid"
            :to="'/org/' + org.currentOrgUid + '/member/' + item.uid"
          >

            <q-card>
              <q-card-actions>

                <q-btn
                  flat
                  icon="mdi-delete"
                  size="sm"
                  @click="org.deleteMemberOrg(item.uid)"
                  >{{ $t("nav.delete") }}</q-btn
                >
              </q-card-actions>
            </q-card>
          </q-expansion-item>
        </q-expansion-item>
      -->

      <!-- MEMBERS -->
      <q-expansion-item
        expand-separator
        icon="mdi-account-multiple"
        :label="$t('orgs.drawer.membersLabel')"
        :caption="$t('orgs.drawer.membersCaption')"
        group="org-management"
        header-class="text-weight-bolder"
      >
        <!-- MEMBER SEARCH -->
        <!-- <q-item>
          <q-item-section avatar>
            <q-icon name="mdi-account-search" />
          </q-item-section>
          <q-input label="Search Members"></q-input>
        </q-item>
        -->

        <!-- LIST SEARCH MEMBERS -->
        <q-expansion-item
          v-for="[ix, item] in org.$state.orgMembers"
          :key="ix"
          expand-icon-toggle
          expand-separator
          :label="item.name"
          :caption="item.uid"
          :to="'/org/' + org.currentOrgUid + '/member/' + item.uid"
        >
          <!-- MEMBER QUICKVIEW -->
          <q-card>
            <q-card-actions>
              <!-- MEMBER QUICKVIEW CONTROLS -->
              <q-btn
                flat
                icon="mdi-delete"
                size="sm"
                @click="org.deleteMemberOrg(item.uid)"
                >{{ $t("nav.delete") }}</q-btn
              >
            </q-card-actions>
          </q-card>
        </q-expansion-item>

        <!-- ADD MEMBER -->
        <q-item clickable @click="org.triggerNewMemberDialog">
          <q-item-section avatar>
            <q-icon name="mdi-account-plus" />
          </q-item-section>
          <q-item-section>
            <q-item-label>{{
              $t("orgs.drawer.newMemberLabel")
            }}</q-item-label>
            <q-item-label caption>
              {{ $t("orgs.drawer.newMmemberCaption") }}
            </q-item-label>
          </q-item-section>
        </q-item>

        <!-- MEMBERS DASHBOARD - BROWSE MEMBERS -->
        <q-item clickable :to="'/org/' + org.currentOrgUid + '/members'">
          <q-item-section avatar>
            <q-icon name="mdi-account-group" />
          </q-item-section>
          <q-item-section>
            <q-item-label>{{
              $t("orgs.drawer.membersDashboardLabel")
            }}</q-item-label>
            <q-item-label caption>
              {{ $t("orgs.drawer.membersDashboardCaption") }}
            </q-item-label>
          </q-item-section>
        </q-item>
      </q-expansion-item>

      <!-- LOGBOOK -->
      <q-separator></q-separator>
      <q-item clickable :to="'/org/' + org.currentOrgUid + '/logbook'">
        <q-item-section avatar>
          <q-icon name="mdi-book-cog" />
        </q-item-section>
        <q-item-section>
          <q-item-label class="text-weight-bolder">{{ $t("orgs.drawer.logbookLabel") }}</q-item-label>
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
