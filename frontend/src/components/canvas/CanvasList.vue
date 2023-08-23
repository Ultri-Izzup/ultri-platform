<template>
  <div>
    <div class="row q-pa-lg justify-center">
      <div class="col-7 q-pa-md">
        <q-card class="q-pa-md">
          <q-card-section>
            <p class="text-h5">{{ $t("canvas.description") }} </p>
            <ul>
              <li><p class="text-h6">{{ $t("canvas.features.download") }}</p></li>
              <li><p class="text-h6">{{ $t("canvas.features.upload") }}</p></li>
              <li><p class="text-h6">{{ $t("canvas.features.soon") }}</p></li>
            </ul>
          </q-card-section>
          <q-card-section>
            <p class="text-bold text-center">{{ $t("canvas.callForAdditions") }}</p>
          </q-card-section>
        </q-card>
      </div>
      <!-- Business Model Card -->
      <div class="col-6 q-pa-md">
        <q-card class="q-pa-md">
          <q-card-section>
            <p class="text-h6">{{ $t("canvas.business.description") }}</p>
            <span class="text-italic text-orange q-pl-md"
              ><q-icon name="mdi-star" color="orange" />{{
                $t("canvas.active")
              }}</span
            >
          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn
              :to="{ name: toRoute, params: { canvasTemplate: 'businessModel' } }"
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
            <p class="text-h6">{{ $t("canvas.s3.organization.description") }}</p>
            <span class="text-italic text-orange q-pl-md"
              ><q-icon name="mdi-star" color="orange" />{{
                $t("canvas.active")
              }}</span
            >
          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn
              :to="{ name: toRoute, params: { canvasTemplate: 's3Organization' } }"
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
            <p class="text-h6">{{ $t("canvas.s3.delegation.description") }}</p>
            <span class="text-italic text-orange q-pl-md"
              ><q-icon name="mdi-star" color="orange" />{{
                $t("canvas.active")
              }}</span
            >
          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn
              :to="{ name: toRoute, params: { canvasTemplate: 's3Delegation' } }"
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
            <p class="text-h6">{{ $t("canvas.s3.team.description") }}</p>
          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn
              :to="{ name: toRoute, params: { canvasTemplate: 's3Team' } }"
              color="primary"
              >{{ $t("canvas.s3.team.name") }}</q-btn
            >
          </q-card-actions>
        </q-card>
      </div>

      <div class="col-6 q-pa-md">
        <q-card class="q-pa-md">
          <q-card-section>
            <p class="text-h6">{{ $t("canvas.coop.description") }}</p>
            <span class="text-italic text-orange q-pl-md"
              ><q-icon name="mdi-star" color="orange" />{{
                $t("canvas.active")
              }}</span
            >
          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn
              :to="{ name: toRoute, params: { canvasTemplate: 'coopOwnership' } }"
              color="primary"
              >{{ $t("canvas.coop.name") }}</q-btn
            >
          </q-card-actions>
        </q-card>
      </div>

      <div class="col-6 q-pa-md">
        <q-card class="q-pa-md">
          <q-card-section>
            <p class="text-h6">{{ $t("canvas.lean.description") }}</p>
          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn
              :to="{ name: toRoute, params: { canvasTemplate: 'leanCanvas' } }"
              color="primary"
              >{{ $t("canvas.lean.name") }}</q-btn
            >
          </q-card-actions>
        </q-card>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useRoute } from "vue-router";
const route = useRoute();

const orgUid = route.params.orgUid;

const toRoute = ref("canavaTemplateViewer");

if (orgUid) {
  toRoute.value = "orgCanvasPage";
}
</script>
