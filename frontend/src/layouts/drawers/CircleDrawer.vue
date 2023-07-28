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
            : $t('orgs.drawer.select-organization')
        "
        header-class="text-weight-bolder"
        :caption="
          org.currentOrgUid
            ? $t('orgs.drawer.current-organization')
            : $t('orgs.drawer.select-or-create-an-organization')
        "
      >
        <!-- ADD ORGANIZATION -->
        <q-item clickable @click="org.triggerOrgCreateDialog">
          <q-item-section avatar>
            <q-icon name="mdi-office-building-plus" />
          </q-item-section>
          <q-item-section>
            <q-item-label>{{ $t("orgs.new-org") }}</q-item-label>
            <q-item-label caption>
              {{ $t("orgs.create-an-org") }}
            </q-item-label>
          </q-item-section>
        </q-item>

        <!-- LIST ORGANIZATIONS -->
        <q-item header dense v-if="org.orgs.size > 0">
          <div class="text-center full-width text-bold text-italic">
            {{ $t("orgs.drawer.current-organizations") }}
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
        :label="$t('orgs.drawer.define-org-label')"
        :caption="$t('orgs.drawer.define-org-caption')"
        group="top-level"
        header-class="text-weight-medium"
      >
        <!-- MISSION STATEMENT -->
        <q-expansion-item
          expand-separator
          icon="mdi-script-text"
          :label="$t('orgs.drawer.mission-statement-label')"
          :caption="$t('orgs.drawer.mission-statement-caption')"
          group="org-management"
          header-class="text-weight-medium"
        >
          <div v-if="org.nuggetUid">Org Nugget Exists</div>
          <div v-else class="text-center justify-center q-py-md">
            <q-btn label="Define Mission" @click="org.triggerOrgMissionDialog"></q-btn>
          </div>
        </q-expansion-item>

        <!-- OKR -->
        <q-expansion-item
          expand-separator
          icon="mdi-checkbook"
          :label="$t('orgs.drawer.okr-label')"
          :caption="$t('orgs.drawer.okr-caption')"
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

        <!-- DRIVERS -->
        <q-expansion-item
          expand-separator
          icon="mdi-sign-direction"
          :label="$t('orgs.drawer.drivers-label')"
          :caption="$t('orgs.drawer.drivers-caption')"
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
                $t("orgs.drawer.new-driver-label")
              }}</q-item-label>
              <q-item-label caption>
                {{ $t("orgs.drawer.new-driver-caption") }}
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
                $t("orgs.drawer.drivers-dashboard-label")
              }}</q-item-label>
              <q-item-label caption>
                {{ $t("orgs.drawer.drivers-dashboard-caption") }}
              </q-item-label>
            </q-item-section>
          </q-item>
        </q-expansion-item>

        <!-- DOMAINS -->
        <q-expansion-item
          expand-separator
          icon="mdi-domain"
          :label="$t('orgs.drawer.domains-label')"
          :caption="$t('orgs.drawer.domains-caption')"
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
                $t("orgs.drawer.new-domain-label")
              }}</q-item-label>
              <q-item-label caption>
                {{ $t("orgs.drawer.new-domain-caption") }}
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
                $t("orgs.drawer.domains-dashboard-label")
              }}</q-item-label>
              <q-item-label caption>
                {{ $t("orgs.drawer.domains-dashboard-caption") }}
              </q-item-label>
            </q-item-section>
          </q-item>
        </q-expansion-item>

        <!-- CANVAS -->
        <q-expansion-item
          expand-separator
          icon="mdi-checkbook"
          :label="$t('orgs.drawer.canvases-label')"
          :caption="$t('orgs.drawer.canvases-caption')"
          group="org-management"
          header-class="text-weight-medium"
        >
          Access to our dynamic business canvases
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
      </q-expansion-item>

      <!-- METRICS -->
      <!--<q-expansion-item
          expand-separator
          icon="mdi-chart-bar-stacked"
          :label="$t('orgs.drawer.metrics-label')"
          :caption="$t('orgs.drawer.metrics-caption')"
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
        :label="$t('orgs.drawer.members-label')"
        :caption="$t('orgs.drawer.members-caption')"
        group="org-management"
        header-class="text-weight-medium"
      >
        <!-- MEMBER SEARCH -->
        <q-item>
          <q-item-section avatar>
            <q-icon name="mdi-account-search" />
          </q-item-section>
          <q-input label="Search Members"></q-input>
        </q-item>

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
              $t("orgs.drawer.new-member-label")
            }}</q-item-label>
            <q-item-label caption>
              {{ $t("orgs.drawer.new-member-caption") }}
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
              $t("orgs.drawer.members-dashboard-label")
            }}</q-item-label>
            <q-item-label caption>
              {{ $t("orgs.drawer.members-dashboard-caption") }}
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
          <q-item-label>{{ $t("orgs.drawer.logbook-label") }}</q-item-label>
          <q-item-label caption>
            {{ $t("orgs.drawer.logbook-dashboard-caption") }}
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
