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
const auth = useAuthStore();
const org = useOrgStore();
const nugget = useNuggetStore();
const color = useColorStore();
const canvas = useCanvasStore();
const socket = useSocketStore();

const clearStores = () => {
  console.log("Clearing stores")
  auth.$reset();
  org.$reset();
  nugget.reset();
  color.reset();
  canvas.reset();
  socket.$reset();
};
</script>
