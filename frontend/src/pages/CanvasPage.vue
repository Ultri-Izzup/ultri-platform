<template>
  <q-page class="flex justify-center outer-container">
    <!-- THIS DIV IS VISIBLE ON A X-SMALL SCREEN (class=xs)-->
    <div class="xs row full-width">
      <div class="row full-width" style="height: 11%">
        <div class="col key-partners q-ma-xs">
          <div class="infobox fit q-pa-xs">X-SMALL Key Partners</div>
        </div>
      </div>
      <div class="row full-width" style="height: 11%">
        <div class="row full-width">
          <div class="col key-activities q-ma-xs">
            <div class="infobox fit q-pa-xs">Key Activities</div>
          </div>
        </div>
      </div>

      <div class="row full-width" style="height: 11%">
        <div class="col key-resources q-ma-xs">
          <div class="infobox fit q-pa-xs">Key Resources</div>
        </div>
      </div>

      <div class="row full-width" style="height: 11%">
        <div class="row full-width">
          <div class="col value-propositions q-ma-xs">
            <div class="infobox fit q-pa-xs">Value Propositions</div>
          </div>
        </div>
      </div>

      <div class="row full-width" style="height: 11%">
        <div class="row full-width">
          <div class="col customer-relationships q-ma-xs">
            <div class="infobox fit q-pa-xs">Customer Relationships</div>
          </div>
        </div>
      </div>

      <div class="row full-width" style="height: 11%">
        <div class="row full-width">
          <div class="row channels full-width key-resources q-ma-xs">
            <div class="infobox fit q-pa-xs">Channels</div>
          </div>
        </div>
      </div>

      <div class="row full-width" style="height: 11%">
        <div class="row full-width">
          <div class="col customer-segments q-ma-xs">
            <div class="infobox fit q-pa-xs">Customer Segments</div>
          </div>
        </div>
      </div>

      <div class="row full-width" style="height: 11%">
        <div class="row full-width">
          <div class="col cost-structure q-ma-xs">
            <div class="infobox fit q-pa-xs">Cost Structure</div>
          </div>
        </div>
      </div>

      <div class="row full-width" style="height: 12%">
        <div class="row full-width">
          <div class="col revenue-stream q-ma-xs">
            <div class="infobox fit q-pa-xs">Revenue Stream</div>
          </div>
        </div>
      </div>
    </div>
    <!-- THIS DIV IS VISIBLE ON A MEDIUM SCREEN (class=md)-->
    <div class="gt-xs lt-lg row full-width">
      <div class="row full-width">
        <div class="row full-width key-activities" style="height: 33%">
          <div class="row full-width">
            <div class="col key-partners q-ma-sm">
              <div class="infobox fit q-pa-sm">MEDIUM Key Partners</div>
            </div>
            <div class="col fit">
              <div class="row fit">
                <div class="row full-width key-activities">
                  <div class="q-pa-sm fit">
                    <div class="infobox fit q-pa-sm">Key Activities</div>
                  </div>
                </div>
                <div class="row full-width key-resources">
                  <div class="q-pa-sm fit">
                    <div class="infobox fit q-pa-sm">Key Resources</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row full-width key-resources" style="height: 14%">
          <div class="col value-propositions q-ma-sm">
            <div class="infobox fit q-pa-sm">Value Propositions</div>
          </div>
        </div>
        <div class="row full-width key-resources" style="height: 33%">
          <div class="col fit">
            <div class="row fit">
              <div class="row customer-relationships full-width key-activities">
                <div class="q-pa-sm fit">
                  <div class="infobox fit q-pa-sm">Customer Relationships</div>
                </div>
              </div>
              <div class="row channels full-width key-resources">
                <div class="q-pa-sm fit">
                  <div class="infobox fit q-pa-sm">Channels</div>
                </div>
              </div>
            </div>
          </div>
          <div class="col customer-segments q-ma-sm">
            <div class="infobox fit q-pa-sm">Customer Segments</div>
          </div>
        </div>
        <div class="row full-width key-resources" style="height: 20%">
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
    <!-- THIS DIV IS VISIBLE ON A SCREEN GREATER THAN MEDIUM (class=sm)-->
    <div class="gt-md row full-width">
      <div class="row full-width">
        <div class="row full-width key-activities" style="height: 80%">
          <div class="row full-width">
            <div class="col key-partners q-ma-sm">
              <div class="infobox fit">
                <div class="col">
                  <div class="row box-head justify-center q-pa-xs text-bold text-h6">
                    <q-space />Key Partners<q-space /><q-icon name="mdi-plus-circle-outline" size="sm" class="q-mr-md" @click="showEntryDialog('partners')"></q-icon>
                  </div>
                  <div class="row box-body q-pa-sm">
                    <ol type="A">
                      <li v-for="partner in partners"  :key="partner.uid" @click="showEditDialog('partner', partner.uid)">
                        {{ partner.txt }}
                      </li>

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
        <div class="row full-width key-resources" style="height: 20%">
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
    <q-dialog v-model="newEntryDialog" persistent>
      <q-card style="min-width: 350px">
        <q-card-section class="text-h6">Add {{newEntryType}} value</q-card-section>

        <q-card-section class="q-pt-none">
          <q-input type="textarea" dense v-model="newEntryTxt" autofocus @keyup.enter="prompt = false"></q-input>
        </q-card-section>

        <q-card-actions align="right" class="text-primary">
          <q-btn flat label="Cancel" v-close-popup></q-btn>
          <q-btn flat label="Add" @click="addEntry" v-close-popup></q-btn>
        </q-card-actions>
      </q-card>
    </q-dialog>
    <q-dialog v-model="editEntryDialog" persistent>
      <q-card style="min-width: 350px">
        <q-card-section class="text-h6">Edit {{editEntryType}} value</q-card-section>

        <q-card-section class="q-pt-none">
          <q-input type="textarea" dense v-model="editEntryTxt" autofocus @keyup.enter="prompt = false"></q-input>
        </q-card-section>

        <q-card-actions align="right" class="text-primary">
          <q-btn flat label="Delete"  @click="deleteEntry" v-close-popup></q-btn>
          <q-space />
          <q-btn flat label="Cancel" v-close-popup></q-btn>
          <q-btn flat label="Update" @click="updateEntry" v-close-popup></q-btn>
        </q-card-actions>
      </q-card>
    </q-dialog>
  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { nanoid } from 'nanoid'

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
}
.outer-card-container {
  border-style: dotted;
}
.card-section-container {
  border-style: dashed;
}
.canvas-container {
  border-style: solid;
  background-color: white;
}
</style>
