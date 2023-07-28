<template>
  <div>
    {{  circles }}
  </div>
</template>

<script setup>

import { useOrgStore } from "../stores/org";
import { useRoute } from "vue-router";
import { ref } from "vue";

import CircleViewer from "../components/CircleViewer.vue";

const route = useRoute();

const org = useOrgStore();

org.loadLogbookEntries(route.params.orgUid);

const circles = ref(new Map());

circles.value.set('1', {
    name: 'Top Level Circle',
    leader: 'Brian',
    delegate: 'Brian',
    facilitator: 'Brian',
    secretary: 'Brian',
    domain: 'All major decisions until a successful business formation',
    circles: ['1234','5678','9012']
});

circles.value.set('1234', {
    name: 'Tech Circle',
    leader: 'Brian',
    delegate: 'Denis',
    facilitator: 'Brian',
    secretary: 'Brian',
    domain: 'Technical work',
    circles: ['3456','7890']
});

circles.value.set('5678', {
    name: 'Product Circle',
    leader: 'Brian',
    delegate: 'Brian',
    facilitator: 'Brian',
    secretary: 'Brian',
    domain: 'Product decisions',
    circles: []
});

circles.value.set('9012', {
    name: 'Design Circle',
    leader: 'Brian',
    delegate: 'Brian',
    facilitator: 'Brian',
    secretary: 'Brian',
    domain: 'Design decisions',
    circles: []
});

circles.value.set('3456', {
    name: 'Infrastructure Circle',
    leader: 'Brian',
    delegate: 'Denis',
    facilitator: 'Brian',
    secretary: 'Brian',
    domain: 'AWS work',
    circles: []
});

circles.value.set('7890', {
    name: 'Platform Circle',
    leader: 'Brian',
    delegate: 'Denis',
    facilitator: 'Brian',
    secretary: 'Brian',
    domain: 'Platform coding work',
    circles: []
});

</script>

<style lang="scss">
.greyed {
  background-color: lightgray;
}
</style>
