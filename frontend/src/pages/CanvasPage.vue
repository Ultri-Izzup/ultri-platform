<template>
  <component :is="BusinessCanvas"></component>
</template>

<script setup>
import { ref } from "vue";
import { nanoid } from "nanoid";
import TextClamp from "vue3-text-clamp";
import URow from "../components/ultri/URow.vue";
import BusinessCanvas from "../components/canvas/BusinessCanvas.vue";
import CoopCanvas from "../components/canvas/CoopCanvas.vue";

// const newEntryDialog = ref(false);
// const newEntryType = ref(false);
// const newEntryTxt = ref(null);

// const editEntryDialog = ref(false);
// const editEntryType = ref(false);
// const editEntryTxt = ref(null);
// const editEntryUid = ref(null);

// const showEntryDialog = (box) => {
//   console.log(box);
//   newEntryType.value = box;
//   newEntryDialog.value = true;
// };

// const showEditDialog = (boxType, uid) => {
//   const editObj = partners.value.filter((obj) => obj.uid == uid);
//   console.log(editObj[0].txt);
//   editEntryTxt.value = editObj[0].txt;
//   editEntryType.value = boxType;
//   editEntryUid.value = editObj[0].uid;
//   editEntryDialog.value = true;
// };

// const addEntry = () => {
//   partners.value.push({ uid: nanoid(), txt: newEntryTxt.value });
//   newEntryTxt.value = null;
// };

// const updateEntry = () => {
//   // We really replace the object
//   partners.value = partners.value.filter(
//     (obj) => obj.uid !== editEntryUid.value
//   );
//   partners.value.push({ uid: nanoid(), txt: editEntryTxt.value });
//   editEntryTxt.value = null;
//   editEntryType.value = null;
//   editEntryUid.value = null;
//   editEntryDialog.value = false;
// };

// const deleteEntry = () => {
//   // We really replace the object
//   partners.value = partners.value.filter(
//     (obj) => obj.uid !== editEntryUid.value
//   );
//   editEntryTxt.value = null;
//   editEntryType.value = null;
//   editEntryUid.value = null;
//   editEntryDialog.value = false;
// };

// const edit = (boxType, uid) => {
//   console.log(boxType, uid);
//   editEntryType.value = boxType;
//   editEntryUid.value = uid;
//   editEntryDialog.value = true;
//   editEntryTxt.value = activities.value;
// };

const lotsOfText =
  "edfweewfwty w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okpppppppe rfdyvgerfviytsfdvcsdgosikppp pppperfdyvgerfviytsfdvcsdgosikppppppperfdyvgerfviytsfdvcsdgosikppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btryvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t r THE_END";

const maxLines = "3";
</script>

<style lang="scss">
//display grid
</style>
<!-- unused code,will keep till discarded -->
<!-- <q-card v-for="item in layout" :key="item.id" :class="item.class">
        <q-card-section class="sticky-title">
          <p>{{ item.title }}</p>
          <q-separator></q-separator>
        </q-card-section>
      </q-card> -->
<!-- <q-card class="key-activities">
        <q-card-section class="sticky-title">
          <p>Key Activities</p>
          <q-separator></q-separator>
        </q-card-section>
        {{ lotsOfText }}www
      </q-card>

      <q-card class="key-resources">
        <q-card-section class="sticky-title"
          ><p>Key Resources</p>
          <q-separator></q-separator>
        </q-card-section>
      </q-card>

      <q-card class="value-propositions">
        <q-card-section class="sticky-title">
          <p>Value Propositions</p>
          <q-separator></q-separator>
        </q-card-section>
      </q-card>

      <q-card class="customer-rel">
        <q-card-section class="sticky-title">
          <p>Customer Relations</p>
          <q-separator></q-separator
        ></q-card-section>
      </q-card>

      <q-card class="channels">
        <q-card-section class="sticky-title">
          <p>Channels</p>
          <q-separator></q-separator>
        </q-card-section>
      </q-card>

      <q-card class="customer-seg">
        <q-card-section class="sticky-title">
          <p>Customer Segments</p>
          <q-separator></q-separator>
        </q-card-section>
      </q-card>

      <q-card class="cost-structure">
        <q-card-section class="sticky-title">
          <p>Cost Structure</p>
          <q-separator></q-separator
        ></q-card-section>
      </q-card>

      <q-card class="revenue">
        <q-card-section class="sticky-title"
          ><p>Revenue Stream</p>
          <q-separator></q-separator
        ></q-card-section>
      </q-card> -->
