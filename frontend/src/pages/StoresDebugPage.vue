<template>
  <div>
    <div class="row">
      <q-btn label="Clear Stores" @click="clearStores"></q-btn>
    </div>
    Auth:
    <vue-json-pretty :data="auth.$state" />
    Org:
    <vue-json-pretty :data="org.$state" />
    Orgs:
    <vue-json-pretty :data="[...org.$state.orgs.entries()]" />
    Nuggets:
    <vue-json-pretty :data="nugget.$state" />
    Colors:
    <vue-json-pretty :data="color.$state" />
    Canvas:
    <vue-json-pretty :data="canvas.$state" />
    Websockets:
    <vue-json-pretty :data="socket.$state" />
    Circles:
    <vue-json-pretty :data="circles.$state" />
    Circle Members:
    <vue-json-pretty :data="circleMembers.$state" />
    Circle Drivers:
    <vue-json-pretty :data="circleDrivers.$state" />
    Circle OKR:
    <vue-json-pretty :data="circleOKR.$state" />
  </div>
</template>

<script setup>
import VueJsonPretty from "vue-json-pretty";
import "vue-json-pretty/lib/styles.css";

import { useAuthStore } from "../stores/auth";
import { useOrgStore } from "../stores/org";
import { useNuggetStore } from "../stores/nugget";
import { useColorStore } from "../stores/color";
import { useCanvasStore } from "../stores/canvas";
import { useSocketStore } from "../stores/socket";
import { useCirclesStore } from "../stores/circles";
import { useCircleMembersStore } from "../stores/circleMembers";
import { useCircleDriversStore } from "../stores/circleDrivers";
import { useCircleOKRStore } from "../stores/circleOKR";

const auth = useAuthStore();
const org = useOrgStore();
const nugget = useNuggetStore();
const color = useColorStore();
const canvas = useCanvasStore();
const socket = useSocketStore();
const circles = useCirclesStore();
const circleMembers = useCircleMembersStore();
const circleDrivers = useCircleDriversStore();
const circleOKR = useCircleOKRStore();

const clearStores = () => {
  console.log("Clearing stores")
  auth.$reset();
  org.$reset();
  nugget.reset();
  color.reset();
  canvas.$reset();
  socket.$reset();
  circles.$reset();
  circleMembers.$reset();
  circleDrivers.$reset();
  circleOKR.$reset();
};
</script>
