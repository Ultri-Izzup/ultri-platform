<template>
  <div>
    <q-toolbar class="bg-primary text-white shadow-2">
      <q-btn
        flat
        icon="mdi-arrow-left"
        size="md"
        v-if="orgUid"
        no-caps
        clickable
        :to="{ name: 'orgDashboard', params: { orgUid: orgUid } }"
        ><q-toolbar-title>Ultri - Canvas</q-toolbar-title></q-btn
      ><q-toolbar-title v-if="!orgUid">Ultri - Canvas</q-toolbar-title>
    </q-toolbar>
    <q-list>
      <q-item
        clickable
        v-ripple
        :to="{ name: toRoute, params: { canvasName: 'business' } }"
      >
        <q-item-section label>
          <q-item-label class="text-bold"
            >{{ $t("canvas.business.name") }}
            <span class="text-italic text-orange q-pl-md"
              ><q-icon name="mdi-star" color="orange" />{{
                $t("canvas.active")
              }}</span
            ></q-item-label
          >
        </q-item-section>
      </q-item>
      <q-separator></q-separator>

      <q-item
        clickable
        v-ripple
        :to="{ name: toRoute, params: { canvasName: 's3organization' } }"
      >
        <q-item-section>
          <q-item-label class="text-bold"
            >{{ $t("canvas.s3.organization.name")
            }}<span class="text-italic text-orange q-pl-md"
              ><q-icon name="mdi-star" color="orange" />{{
                $t("canvas.active")
              }}</span
            ></q-item-label
          >
        </q-item-section>
      </q-item>
      <q-separator></q-separator>

      <q-item
        clickable
        v-ripple
        :to="{ name: toRoute, params: { canvasName: 's3delegation' } }"
      >
        <q-item-section>
          <q-item-label class="text-bold"
            >{{ $t("canvas.s3.delegation.name")
            }}<span class="text-italic text-orange q-pl-md"
              ><q-icon name="mdi-star" color="orange" />{{
                $t("canvas.active")
              }}</span
            ></q-item-label
          >
        </q-item-section>
      </q-item>
      <q-separator></q-separator>

      <q-item
        clickable
        v-ripple
        :to="{ name: toRoute, params: { canvasName: 's3team' } }"
      >
        <q-item-section>
          <q-item-label class="text-bold">{{
            $t("canvas.s3.team.name")
          }}</q-item-label>
        </q-item-section>
      </q-item>
      <q-separator></q-separator>

      <q-item
        clickable
        v-ripple
        :to="{ name: toRoute, params: { canvasName: 'coop' } }"
      >
        <q-item-section>
          <q-item-label class="text-bold">{{
            $t("canvas.coop.name")
          }} <span class="text-italic text-orange q-pl-md"
              ><q-icon name="mdi-star" color="orange" />{{
                $t("canvas.active")
              }}</span
            ></q-item-label>
        </q-item-section>
      </q-item>
      <q-separator></q-separator>

      <q-item
        clickable
        v-ripple
        :to="{ name: toRoute, params: { canvasName: 'lean' } }"
      >
        <q-item-section>
          <q-item-label class="text-bold">{{
            $t("canvas.lean.name")
          }}</q-item-label>
        </q-item-section>
      </q-item>
      <q-separator></q-separator>
    </q-list>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useRoute } from "vue-router";
const route = useRoute();

const orgUid = route.params.orgUid;

const toRoute = ref("canvasPage");

if (orgUid) {
  toRoute.value = "orgCanvasPage";
}
</script>

<style lang="scss"></style>
