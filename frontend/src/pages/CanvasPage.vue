<template>
  <q-page class="flex justify-center outer-container">
    <div class="full-width container">
      <u-row height="80">
        <div class="col q-pa-md">
          <q-card class="full-height u-box">
            <q-card-section>
              Key Partners
            </q-card-section>
          </q-card>
        </div>
        <div class="col fit">
          <u-row height="50" class="q-pa-md">
            <q-card class="full-width u-box">
              <q-card-section>
                Key Activities
              </q-card-section>
            </q-card>
          </u-row>
          <div class="row u-height-50 q-pa-md">
            <q-card class="full-width u-box">
              <q-card-section>
                Key Resources
              </q-card-section>
            </q-card>
          </div>
        </div>
        <div class="col q-pa-md">
          <q-card class="full-height u-box">
            <q-card-section>
              Value Propositions
            </q-card-section>
          </q-card>
        </div>
        <div class="col">
          <div class="row u-height-50  q-pa-md">
            <q-card class="full-width u-box">
              <q-card-section>
                Customer Relations
              </q-card-section>
            </q-card>
          </div>
          <div class="row u-height-50  q-pa-md">
            <q-card class="full-width u-box">
              <q-card-section>
                Channels
              </q-card-section>
            </q-card>
          </div>
        </div>
        <div class="col q-pa-md">
          <q-card class="full-height u-box">
            <q-card-section>
              Customer Segments
            </q-card-section>
          </q-card>
        </div>
      </u-row>
      <u-row height="20">
        <div class="col q-pa-md">
          <q-card class="full-height u-box">
            <q-card-section>
              Cost Structure
            </q-card-section>
          </q-card>
        </div>
        <div class="col q-pa-md">
          <q-card class="full-height u-box">
            <q-card-section>
              Revenue Stream
            </q-card-section>
          </q-card>
        </div>
      </u-row>
    </div>
  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { nanoid } from 'nanoid';
import TextClamp from 'vue3-text-clamp';
import URow from '../components/ultri/URow.vue';

const partners = ref([]);
const activities = ref([]);
const resources = ref([]);
const valueProps = ref([]);
const custRelations = ref([]);
const channels = ref([]);
const custSegments = ref([]);
const costs = ref([]);
const revenue = ref([]);

const newEntryDialog = ref(false);
const newEntryType = ref(false);
const newEntryTxt = ref(null);

const editEntryDialog = ref(false);
const editEntryType = ref(false);
const editEntryTxt = ref(null);
const editEntryUid = ref(null);

const showEntryDialog = (box) => {
  console.log(box)
  newEntryType.value = box;
  newEntryDialog.value = true;
}

const showEditDialog = (boxType, uid) => {

  const editObj = partners.value.filter((obj) => obj.uid == uid);
  console.log(editObj[0].txt)
  editEntryTxt.value = editObj[0].txt;
  editEntryType.value = boxType;
  editEntryUid.value = editObj[0].uid;
  editEntryDialog.value = true;
}

const addEntry = () => {
  partners.value.push({ uid: nanoid(), txt: newEntryTxt.value })
  newEntryTxt.value = null;
}

const updateEntry = () => {
  // We really replace the object
  partners.value = partners.value.filter((obj) => obj.uid !== editEntryUid.value);
  partners.value.push({ uid: nanoid(), txt: editEntryTxt.value })
  editEntryTxt.value = null;
  editEntryType.value = null;
  editEntryUid.value = null;
  editEntryDialog.value = false;
}

const deleteEntry = () => {
  // We really replace the object
  partners.value = partners.value.filter((obj) => obj.uid !== editEntryUid.value);
  editEntryTxt.value = null;
  editEntryType.value = null;
  editEntryUid.value = null;
  editEntryDialog.value = false;
}

const edit = (boxType, uid) => {

  console.log(boxType, uid);
  editEntryType.value = boxType;
  editEntryUid.value = uid;
  editEntryDialog.value = true;
  editEntryTxt.value = activities.value;

}

const lotsOfText = "edfweewfwty w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppperfdyvgerfviytsfdvcsdgosikppppppperfdyvgerfviytsfdvcsdgosikppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btryvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t r THE_END";

const maxLines = "3";
</script>

<style lang="scss">
.container {
  background-color: lightgray
}

.col1 {
  background-color: lightblue;
  //  margin: 5px;
  // padding: 5px;
}

.col2 {
  background-color: lightcoral;
  // margin: 5px;
}

.col3 {
  background-color: lightsalmon;
  // margin: 5px;
}

.col4 {
  background-color: greenyellow;
  // margin: 5px;
}

.col5 {
  background-color: orchid;
  // margin: 5px;
}

.col1-2 {
  background-color: steelblue;
  // margin: 5px;
}

.col2-2 {
  background-color: peru;
  //margin: 5px;
}

.u-height-50 {
  height: 50%;
}

.u-box {
  border-radius: 5px;
  border-color: lightgray;
  border-style: solid;
  border-width: 2px;
}


.box-head {
  background-color: $primary;
  border-color: $primary;
  border-top-left-radius: 0.5em;
  border-top-right-radius: 0.5em;
  color: white;
}

.infobox {
  border: solid;
  border-color: lightgrey;
  border-radius: 1em;
}

.outer-container {
  border-style: double;
  border-color: blue;
}

.canvas-box {
  border-style: dotted;
  padding: 5px;
  margin: 5px;
  border-color: green;
}

.card-section-container {
  border-style: dashed;
}

.canvas-container {
  border-style: solid;
  background-color: white;
}</style>
