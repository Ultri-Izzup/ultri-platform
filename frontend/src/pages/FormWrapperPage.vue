<template>
  <q-page class="flex flex-center">
    <keep-alive>
      <component :is="currentComponent"/>
    </keep-alive>
    </q-page>
</template>

<script setup>
import { computed } from "vue";
import { useRoute } from "vue-router";

import ProposalForm from "./forms/ProposalForm.vue";

const route = useRoute();
const formName = route.params.formName;

const forms = {
      proposal: ProposalForm,
    };

const currentComponent = computed(() => forms[formName])

</script>
