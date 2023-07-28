<template>
  <div>
    {{ circles }}
    <svg :width="width" :height="height">
      <path fill="none" stroke="currentColor" stroke-width="1.5" d={line(data)} />
      <g fill="white" stroke="currentColor" stroke-width="1.5">
        <circle key="1" cx="34" cy="100" r="2.5" />
      </g>
    </svg>
  </div>
</template>

<script setup>
import * as d3 from "d3";

const props = defineProps({
  circles: Map
})

// Declare the chart dimensions and margins.
const width = 640;
const height = 400;
const marginTop = 20;
const marginRight = 20;
const marginBottom = 30;
const marginLeft = 40;



</script>
