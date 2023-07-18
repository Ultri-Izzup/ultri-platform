<template>
  <q-page class="flex justify-center outer-container">
    <div class="row full-width">
      <div class="col key-partners">Key Partners</div>
      <div class="col fit">
        <div class="row fit">
          <div class="row full-width key-activities">Key Activities</div>
          <div class="row full-width key-resources">Key Resources</div>
        </div>
      </div>

      <div class="col value-propositions">Value Propositions</div>

      <div class="col fit">
        <div class="row fit">
          <div class="row customer-relationships full-width key-activities">
            Customer Relationships
          </div>
          <div class="row channels full-width key-resources">Channels</div>
        </div>
      </div>

      <div class="col customer-segments">Customer Segments</div>
    </div>
    <div class="row full-width">
      <div class="col cost-structure">Cost Structure</div>
      <div class="col revenue-stream">Revenue Stream</div>
    </div>
  </q-page>
</template>

<script setup>
import BusinessCanvas from "../components/canvas/BusinessCanvas.vue";
</script>

<style lang="scss">
.outer-container {
  border-style: double;
}
.outer-card-container {
  border-style: dotted;
}
.card-section-container {
  border-style: dashed;
  border-color: blue;
}
.canvas-container {
  border-style: solid;
  background-color: grey;
}
.key-partners {
  color: white;
  background-color: green;
}
.key-resources {
  color: black;
  background-color: yellow;
}
.key-activities {
  color: white;
  background-color: blueviolet;
}
.value-propositions {
  color: black;
  background-color: aqua;
}
.customer-relationships {
  color: black;
  background-color: darkcyan;
}
.channels {
  color: white;
  background-color: orange;
}
.customer-segments {
  color: black;
  background-color: purple;
}
.cost-structure {
  color: white;
  background-color: red;
}
.revenue-stream {
  color: white;
  background-color: green;
}
</style>
