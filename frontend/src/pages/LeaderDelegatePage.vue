<template>
  <div class="flex fit">
    <h2>Leader and Delegate Relations</h2>
    <div class="fit">
      <vue3-mermaid
        :nodes="data"
        type="flowchart"
        @nodeClick="editNode"
      ></vue3-mermaid>
    </div>
  </div>
</template>

<script setup>
const data = [
  {
    id: "mission",
    text: "Mission",
    next: ["general"],
    edgeType: "circle",
    link: "-- Brian --->",
  },
  { id: "general", text: "General", edgeType: "circle", next: ["mission"], link: "-. Gail .->" },
  { id: "general", text: "General", edgeType: "circle", next: ["product"], link: "-- Tom --->" },
  { id: "general", text: "General", edgeType: "circle", next: ["tech"], link: "-- Geoff --->" },
  { id: "product", text: "Product", edgeType: "circle", next: ["general"], link: "-. Ted .->" },
  { id: "product", text: "Product", edgeType: "circle", },
  { id: "tech", text: "Tech", edgeType: "circle", next: ["general"], link: "-. Rae .->" },
  { id: "tech", text: "Tech", edgeType: "circle" },
  // { id: "3", text: "C", link:"----", next: ["4", "6"] },
  // { id: "4", text: "D", link: "-- This is the text ---", next: ["5"] },
  // { id: "5", text: "E" },
  // { id: "6", text: "F" },
];

const editNode = (nodeId) => {
  alert(nodeId);
};
</script>
<style></style>
