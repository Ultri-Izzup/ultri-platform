<template>
  <q-page class="row fit canvas-container">
    <div class="col fit xs">
      <div class="row fit auto-grow key-partners">XS Key Partners</div>
      <div class="row key-activities">Key Activities</div>
      <div class="row key-resources">Key Resources</div>
      <div class="row value-propositions">Value Propositions</div>
      <div class="row customer-relationships">
        Customer Relationships
      </div>
      <div class="row channels">Channels</div>
      <div class="row customer-segments">Customer Segments</div>
      <div class="row cost-structure">Cost Structure</div>
      <div class="row revenue-stream fit">Revenue Stream</div>
    </div>
    <div class="row fit gt-xs lt-lg">
      <div class="col-6 key-partners">SM&MD Key Partners</div>
      <div class="col-2 key-activities">Key Activities</div>
      <div class="col-2 key-resources">Key Resources</div>
      <div class="col-6 value-propositions">Value Propositions</div>
      <div class="col-2 customer-relationships">
        Customer Relationships
      </div>
      <div class="col-2  channels">Channels</div>
      <div class="col-6  customer-segments">Customer Segments</div>
      <div class="col-2 cost-structure">Cost Structure</div>
      <div class="col-2 revenue-stream">Revenue Stream</div>
    </div>
    <div class="row fit gt-md">
      <div class="col-2 key-partners">LG&XL Key Partners</div>
      <div class="col-2 key-activities">Key Activities</div>
      <div class="col-2 key-resources">Key Resources</div>
      <div class="col-2 value-propositions">Value Propositions</div>
      <div class="col-2 customer-relationships">
        Customer Relationships
      </div>
      <div class="col-2  channels">Channels</div>
      <div class="col-2  customer-segments">Customer Segments</div>
      <div class="cost-structure">Cost Structure</div>
      <div class="revenue-stream">Revenue Stream</div>
    </div>
  </q-page>
</template>

<script setup>
</script>

<style lang="scss">
.canvas-container {
  border-style: solid;
  background-color: grey;
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
