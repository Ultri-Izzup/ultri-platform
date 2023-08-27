<template>
  <q-dialog ref="dialogRef">
    <q-card>
      <q-card
            class="container-card"
            :class="data.sectionKey"
            :style="
              'background-color: ' +
              data.backgroundColor +
              '; color: ' +
              data.textColor
            "
          >
            <q-card-section
              :class="darkMode ? 'dark-top-q-card' : 'top-q-card'"
              :style="'background-color: ' + data.backgroundColor"
            >
              <p class="text-bold">
                <q-avatar v-if="data.sequence" size="24px" color="grey-4"
                  ><span class="text-grey-8">{{
                    data.sequence
                  }}</span></q-avatar
                >
                {{ data.title }}
                <sup>
                  <q-icon name="mdi-help-circle" size="13px" color="grey-6" />
                  <q-tooltip>
                    <span v-html="data.instructions" />
                  </q-tooltip>
                </sup>
              </p>
              <q-space />
              <q-icon
                name="mdi-close"
                size="20px"
                clickable
                v-ripple

                class="cursor-pointer"
              ></q-icon>
              <q-icon
                name="mdi-plus-circle-outline"
                size="20px"
                clickable
                v-ripple
                @click="triggerNew(data.sectionKey)"
                class="cursor-pointer"
              ></q-icon>
            </q-card-section>
            <q-card-section
              v-if="showInstructions && !data.items"
              v-ripple
              clickable
              @click="triggerNew(data.sectionKey)"
              class="q-pa-md text-italic cursor-pointer q-hoverable"
              ><div v-html="data.instructions" />
            </q-card-section>
            <q-card-section v-if="data.items && showItems" class="q-pa-none">
              <q-list separator>
                <q-item v-for="item in data.items" :key="item.uid">
                  <q-item-section>
                    <q-item-label class="text-bold">
                      {{ item.label }}
                    </q-item-label>
                    <span
                      v-if="showDetail"
                      v-html="item.details"
                      clickable
                      v-ripple
                      @click="editItem(data.sectionKey, item.uid)"
                    ></span>
                  </q-item-section>
                </q-item>
              </q-list>
            </q-card-section>
          </q-card>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, watch, toRefs, toRef, reactive, unref } from "vue";
import { useDialogPluginComponent, useQuasar } from "quasar";

import { v4 as uuidv4 } from "uuid";

import CanavaEditorSection from "../CanavaEditorSection.vue";

const props = defineProps(["data","darkMode"]);

const emit = defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  ...useDialogPluginComponent.emits,
  // These apply to Section Items, not sections themselves.
  "add",
  "modify",
  "remove",
]);

const items = ref();

if(props.items) {
  items.value = unref(props.items);
}

const showInstructions = ref(true);

console.log(items)

const $q = useQuasar();


// watch(
//   () => props.data,
//   () => {
//     edit.value = reactive(props.data);
//   },
//   { immediate: true }
// );

const { dialogRef, onDialogOK } = useDialogPluginComponent();
// dialogRef      - Vue ref to be applied to QDialog
// onDialogHide   - Function to be used as handler for @hide on QDialog
// onDialogOK     - Function to call to settle dialog with "ok" outcome
//                    example: onDialogOK() - no payload
//                    example: onDialogOK({ /*...*/ }) - with payload
// onDialogCancel - Function to call to settle dialog with "cancel" outcome

const onOKClick = () => {
  // on OK, it is REQUIRED to
  // call onDialogOK (with optional payload)
  onDialogOK();
  //primary.value = editPrimary.value;
  // or with payload: onDialogOK({ ... })
  // ...and it will also hide the dialog automatically
};

const save = () => {
  if (edit.value.uid) {
    // Update
    emit("modify", edit.value);
  } else {
    // New
    console.log("NEW");
    edit.value.uid = uuidv4();
    emit("add", edit.value);
  }
  reset();
  onDialogOK();
};

const reset = () => {
  //edit.value = {};
};
</script>
