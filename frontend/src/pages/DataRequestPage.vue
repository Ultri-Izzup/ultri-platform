<template>
  <div class="row full-width text-center justify-center">
    <div class="row full-width text-center justify-center text-h2 text-bold text-primary">{{ $t('dataRequest.h1', 'Data Request Options')}}</div>

    <q-card flat>
      <q-card-section>
        <div class="row full-width text-center justify-center text-body1">{{ $t('dataRequest.body', 'Send an email to data-request@ultri.com, from the same email used to sign in.')}}</div>
        <div class="row full-width text-center justify-center text-body1">We will have a form up here shortly.</div>
      </q-card-section>

    </q-card>


  </div>
</template>

<script setup>
import { ref } from "vue";
import { useQuasar } from "quasar";
import { useAuthStore } from "../stores/auth";
import { useColorStore } from "../stores/color";
import { Screen } from "quasar";

const auth = useAuthStore();
const colorStore = useColorStore();

const $q = useQuasar();
</script>
