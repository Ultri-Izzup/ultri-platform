<template>
  <q-page class="flex justify-center outer-container">
    <div class="row full-width overflow-hidden overflow-hidden-y">
      <div class="row full-width  overflow-hidden overflow-hidden-y">
        <div class="row full-width key-activities  overflow-hidden overflow-hidden-y" style="height: 70vh">
          <div class="row full-width  overflow-hidden overflow-hidden-y">
            <div class="col key-partners q-ma-sm  overflow-hidden overflow-hidden-y">
              <div class="infobox fit">
                <div class="col  overflow-hidden overflow-hidden-y">
                  <div class="row box-head justify-center q-pa-xs text-bold text-h6">
                    <q-space />Key Partners<q-space /><q-icon name="mdi-plus-circle-outline" size="sm" class="q-mr-md" @click="showEntryDialog('partners')"></q-icon>
                  </div>
                  <div class="row box-body q-pa-sm overflow-hidden overflow-hidden-y qa-md">
                    <ol type="A">
                      <text-clamp :text='lotsOfText' :max-lines='2' />
                    </ol>

                  </div>
                </div>
              </div>
            </div>
            <div class="col fit">
              <div class="row fit">
                <div class="row full-width key-activities q-pa-sm">
                  <div class="infobox fit q-pa-sm">Key Activities</div>
                </div>
                <div class="row full-width key-resources q-pa-sm">
                  <div class="infobox fit q-pa-sm">Key Resources</div>
                </div>
              </div>
            </div>

            <div class="col value-propositions q-ma-sm">
              <div class="infobox fit q-pa-sm">Value Propositions</div>
            </div>

            <div class="col fit">
              <div class="row fit">
                <div
                  class="row customer-relationships full-width key-activities q-pa-sm"
                >
                  <div class="infobox fit q-pa-sm">Customer Relationships</div>
                </div>

                <div class="row channels full-width key-resources q-pa-sm">
                  <div class="infobox fit q-pa-sm">Channels</div>
                </div>
              </div>
            </div>

            <div class="col customer-segments q-ma-sm">
              <div class="infobox fit q-pa-sm">Customer Segments</div>
            </div>
          </div>
        </div>
        <div class="row full-width key-resources" style="height: 15vh">
          <div class="row full-width">
            <div class="col cost-structure q-ma-sm">
              <div class="infobox fit q-pa-sm">Cost Structure</div>
            </div>
            <div class="col revenue-stream q-ma-sm">
              <div class="infobox fit q-pa-sm">Revenue Stream</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { nanoid } from 'nanoid';
import TextClamp from 'vue3-text-clamp';

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
}
</style>
