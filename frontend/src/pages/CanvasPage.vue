<template>
  <q-page class="">
    <component :is="currentComponent"></component>
  </q-page>
</template>

<script setup>
// Import computed
import { ref, computed } from "vue";
// Import useRoute composable
import { useRoute} from "vue-router";
import { nanoid } from "nanoid";
import TextClamp from "vue3-text-clamp";
import URow from "../components/ultri/URow.vue";

// Import the canvas components
import BusinessCanvas from "../components/BusinessCanvas.vue";
import CoopCanvas from "../components/CoopCanvas.vue";

// Create a route instance
const route = useRoute();
// Get the canvasName from the route params
const canvasName = route.params.canvasName;

// Define a mapping of canvas names to their respective component name 
const canvases = {
  business: BusinessCanvas,
  coop: CoopCanvas,
};

// Use the current canvasName to find the mapped component
const currentComponent = computed(() => canvases[canvasName])

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
  console.log(box);
  newEntryType.value = box;
  newEntryDialog.value = true;
};

const showEditDialog = (boxType, uid) => {
  const editObj = partners.value.filter((obj) => obj.uid == uid);
  console.log(editObj[0].txt);
  editEntryTxt.value = editObj[0].txt;
  editEntryType.value = boxType;
  editEntryUid.value = editObj[0].uid;
  editEntryDialog.value = true;
};

const addEntry = () => {
  partners.value.push({ uid: nanoid(), txt: newEntryTxt.value });
  newEntryTxt.value = null;
};

const updateEntry = () => {
  // We really replace the object
  partners.value = partners.value.filter(
    (obj) => obj.uid !== editEntryUid.value
  );
  partners.value.push({ uid: nanoid(), txt: editEntryTxt.value });
  editEntryTxt.value = null;
  editEntryType.value = null;
  editEntryUid.value = null;
  editEntryDialog.value = false;
};

const deleteEntry = () => {
  // We really replace the object
  partners.value = partners.value.filter(
    (obj) => obj.uid !== editEntryUid.value
  );
  editEntryTxt.value = null;
  editEntryType.value = null;
  editEntryUid.value = null;
  editEntryDialog.value = false;
};

const edit = (boxType, uid) => {
  console.log(boxType, uid);
  editEntryType.value = boxType;
  editEntryUid.value = uid;
  editEntryDialog.value = true;
  editEntryTxt.value = activities.value;
};

const lotsOfText =
  "edfweewfwty w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okpppppppe rfdyvgerfviytsfdvcsdgosikppp pppperfdyvgerfviytsfdvcsdgosikppppppperfdyvgerfviytsfdvcsdgosikppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btryvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t rewfwef w ef wef ew f we f wef we f erfdgblkpo kokjoi]k ]oko] k]ok]okppppppperfdyvgerfviytsfdvcsdgosikppppppppppppppp fd gvtr gb rt  tyrb  tr ght rg tr b  bt rb tr b tr b tr  rb tr b tr btr b tr btr b t r THE_END";

const maxLines = "3";
</script>

<style lang="scss">
//display grid
.container {
  height: 90vh;
  display: grid;
}

.container > * {
  word-break: break-word;
  overflow: scroll;
  padding: 10px;
  box-shadow: 1px 10px 10px rgba(128, 128, 128, 0.2);
}

.container > * {
  padding: 10px;
  min-height: 100%;
}

@media screen and (min-width: 1300px) {
  .container {
    grid-template-columns: repeat(10, 1fr);
    grid-template-rows: repeat(5, 1fr);
    gap: 10px;
  }
  .key-partners {
    grid-column: 1/3;
    grid-row: 1/5;
  }
  .key-activities {
    grid-column: 3/5;
    grid-row: 1/3;
  }
  .key-resources {
    grid-column: 3/5;
    grid-row: 3/5;
  }
  .value-propositions {
    grid-column: 5/7;
    grid-row: 1/5;
  }
  .customer-rel {
    grid-column: 7/9;
    grid-row: 1/3;
  }
  .channels {
    grid-column: 7/9;
    grid-row: 3/5;
  }
  .customer-seg {
    grid-column: 9/11;
    grid-row: 1/5;
  }
  .cost-structure {
    grid-column: 1/6;
    grid-row: 5/6;
  }
  .revenue {
    grid-column: 6/11;
    grid-row: 5/6;
  }
}
//allows scroll bars to be hidden
::-webkit-scrollbar {
  display: none;
}
.sticky-title {
  position: sticky;
  top: -10px;
  background-color: white;
  z-index: 2;
}
</style>
<!-- unused code,will keep till discarded -->
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
