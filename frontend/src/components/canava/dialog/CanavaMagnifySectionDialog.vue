<template>
  <q-dialog ref="dialogRef" maximized>
    <!-- {{ section }} -->
    <q-card
      class="container-card"
      :class="section.sectionKey + ' full-width'"
      :style="
        'max-width: 900px; background-color: ' +
        section.backgroundColor +
        '; color: ' +
        section.textColor
      "
    >
      <q-card-section
        :class="darkMode ? 'dark-top-q-card' : 'top-q-card'"
        :style="'background-color: ' + section.backgroundColor"
      >
        <div class="row">
          <p class="text-bold">
            <q-avatar v-if="section.sequence" size="24px" color="grey-4"
              ><span class="text-grey-8">{{ section.sequence }}</span></q-avatar
            >
            {{ section.title }}
          </p>
          <q-space />
          <q-icon
            name="mdi-close"
            size="20px"
            clickable
            v-ripple
            v-close-popup="1"
            class="cursor-pointer"
          ></q-icon>
          <q-icon
            name="mdi-plus-circle-outline"
            size="20px"
            clickable
            v-ripple
            @click="triggerNew()"
            class="cursor-pointer"
          ></q-icon>
        </div>
      </q-card-section>
      <q-card-section class="q-pa-none" clickable
            v-ripple
            @click="triggerNew()"
        ><div v-html="section.instructions" />
      </q-card-section>
      <q-card-section v-if="section.items" class="q-pa-none">
        <q-list separator>
          <q-item
            v-for="item in section.items"
            :key="item.uid"
            clickable
            v-ripple
            @click="editItem(item.uid)"
          >
            <q-item-section>
              <q-item-label class="text-bold">
                {{ item.label }}
              </q-item-label>
              <span v-html="item.details"></span>
            </q-item-section>
          </q-item>
        </q-list>
      </q-card-section>
    </q-card>
    <CanavaEditorSectionItemDialog
      v-model="showItemDialog"
      :section="section"
      :item="currentItem"
      @save="(event) => emit('save', event)"
      @delete="(event) => emit('delete', event)"
    />
  </q-dialog>
</template>

<script setup>
import { ref, watch, toValue, toRefs, toRef, reactive, unref } from "vue";
import { useDialogPluginComponent, useQuasar } from "quasar";

import { v4 as uuidv4 } from "uuid";

import CanavaEditorSectionItemDialog from "./CanavaEditorSectionItemDialog.vue";

const currentItem = ref({ uid: "", label: "", details: "" });

const props = defineProps(["section", "darkMode"]);

const emit = defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  ...useDialogPluginComponent.emits,
  // These apply to Section Items, not sections themselves.
  "save",
  "delete",
]);

const $q = useQuasar();

const { dialogRef, onDialogOK } = useDialogPluginComponent();

const onOKClick = () => {
  onDialogOK();
};

const showItemDialog = ref(false);

const triggerNew = () => {
  currentItem.value = { uid: "", label: "", details: "" };
  showItemDialog.value = true;
};

const editItem = (itemUid) => {
  const itemData = props.section.items.find((e) => e.uid == itemUid);
  currentItem.value = itemData;

  showItemDialog.value = true;
};
</script>
