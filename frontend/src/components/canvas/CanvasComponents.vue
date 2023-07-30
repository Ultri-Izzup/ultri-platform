<template>
  <q-card>
    <q-card-section class="top-q-card">
      <p>{{ title }}</p>
      <q-icon name="mdi-plus-circle-outline" size="20px"></q-icon>
    </q-card-section>
    <q-separator></q-separator>
    <q-card-section
      >Lorem ipsum dolor sit amet consectetur adipisicing elit. Excepturi
      inventore beatae tempora ipsa deleniti nulla accusamus, alias tenetur hic
      veritatis? Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum
      illum ab eaque quasi accusantium quas, nam tenetur dolores aliquam
      doloremque sunt dignissimos, ipsam ex enim quisquam ratione corrupti
      provident explicabo fugiat officia, sapiente adipisci? Ducimus dolorum non
      quisquam, dicta laborum magnam vero quia nobis? Autem, a. Voluptatem
      similique repellat, rerum totam doloremque omnis eum cum vero ipsam
      quaerat incidunt provident? Maxime, nemo, harum deleniti, quidem dolorem
      non aut mollitia fugit repellat omnis dolorum beatae excepturi eius
      voluptate pariatur consectetur similique odio architecto ipsam. Numquam
      molestiae nihil quibusdam autem, commodi accusantium architecto sunt
      repellendus. Natus magni quis, architecto officiis quam
      corrupti!</q-card-section
    >
  </q-card>
</template>

<script setup>
const props = defineProps({
  title: String,
});
</script>
<style scoped>
::-webkit-scrollbar {
  display: none;
}
.top-q-card {
  position: sticky;
  top: -10px;
  background-color: white;
  z-index: 2;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0px;
  padding-bottom: 10px;
}
p {
  margin: 0;
  padding: 10px;
}

.q-card {
  word-break: break-word;
  overflow: scroll;
  padding: 10px;
  box-shadow: 1px 10px 10px rgba(128, 128, 128, 0.2);
  min-height: 100%;
}
</style>
