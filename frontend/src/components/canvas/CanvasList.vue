<template>
  <div class="row q-pa-lg">
    <!-- Business Model Card -->
    <div class="col-6 q-pa-md">
      <q-card class="q-pa-md">
        <q-card-section>
         {{ $t("canvas.business.description")}}
        </q-card-section>
        <q-card-actions class="justify-center">
          <q-btn
            :to="{ name: toRoute, params: { canvasName: 'business' } }"
            color="primary"
            >{{ $t("canvas.business.name", "Business") }}</q-btn
          >
        </q-card-actions>
      </q-card>
    </div>

    <!-- S3 Organization Card -->
    <div class="col-6 q-pa-md">
      <q-card class="q-pa-md">
        <q-card-section>
         {{ $t("canvas.s3.organization.description")}}
        </q-card-section>
        <q-card-actions class="justify-center">
          <q-btn
          :to="{ name: toRoute, params: { canvasName: 'business' } }"
          color="primary"
          >{{ $t("canvas.s3.organization.name") }}</q-btn
        >
        </q-card-actions>
      </q-card>
    </div>

    <!-- S3 Delegation Card -->
    <div class="col-6 q-pa-md">
      <q-card class="q-pa-md">
        <q-card-section>
         {{ $t("canvas.s3.delegation.description")}}
        </q-card-section>
        <q-card-actions class="justify-center">
          <q-btn
          :to="{ name: toRoute, params: { canvasName: 's3-delegation' } }"
          color="primary"
          >{{ $t("canvas.s3.delegation.name") }}</q-btn
        >
        </q-card-actions>
      </q-card>
    </div>

    <!-- S3 Team Card -->
    <div class="col-6 q-pa-md">
      <q-card class="q-pa-md">
        <q-card-section>
         {{ $t("canvas.s3.team.description")}}
        </q-card-section>
        <q-card-actions class="justify-center">
          <q-btn
          :to="{ name: toRoute, params: { canvasName: 's3-team' } }"
          color="primary"
          >{{ $t("canvas.s3.team.name") }}</q-btn
        >
        </q-card-actions>
      </q-card>
    </div>

    <div class="col-6 q-pa-md">
      <q-card class="q-pa-md">
        <q-card-section>
         {{ $t("canvas.coop.description")}}
        </q-card-section>
        <q-card-actions class="justify-center">
          <q-btn
            :to="{ name: toRoute, params: { canvasName: 'coop' } }"
            color="primary"
            >{{ $t("canvas.coop.name") }}</q-btn
          >
        </q-card-actions>
      </q-card>
    </div>

    <div class="col-6 q-pa-md">
      <q-card class="q-pa-md">
        <q-card-section>
         {{ $t("canvas.lean.description")}}
        </q-card-section>
        <q-card-actions class="justify-center">
          <q-btn
            :to="{ name: toRoute, params: { canvasName: 'lean' } }"
            color="primary"
            >{{ $t("canvas.lean.name") }}</q-btn
          >
        </q-card-actions>
      </q-card>
    </div>


    <!-- <ul>
    <li><router-link :to="{ name: toRoute, params: { canvasName: 'business' }}">{{ $t('canvas.business.name', 'Business') }}</router-link></li>
    <li><router-link :to="{ name: toRoute, params: { canvasName: 'coop' }}">{{ $t('canvas.coop.name', 'Co-op Ownership') }}</router-link></li>
    <li><router-link :to="{ name: toRoute, params: { canvasName: 's3' }}">{{ $t('canvas.s3.name', 'S3') }}</router-link></li>
  </ul>-->
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
