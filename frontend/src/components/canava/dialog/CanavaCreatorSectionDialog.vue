<template>
  <q-dialog ref="dialogRef">
    <q-card>
      <q-bar class="bg-primary">
        Canvas Section
        <q-space></q-space>
        <q-btn
          v-if="edit.value.uid"
          dense
          flat
          icon="mdi-delete"
          v-close-popup
          @click="emit('remove', edit.value.uid)"
          class="q-pr-sm"
        >
          <q-tooltip>{{ $t("nav.delete") }} </q-tooltip>
        </q-btn>
        <q-btn dense flat icon="mdi-close" v-close-popup @click="reset()">
          <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
        </q-btn>
      </q-bar>
      <q-card-section>
        <q-input label="Title" v-model="edit.value.title" />
        <div class="q-pt-sm q-pb-xs text-caption text-grey-8">Instructions</div>
        <q-editor
          v-model="edit.value.instructions"
          min-height="5rem"
          :dense="$q.screen.lt.md"
          :toolbar="[
            ['bold', 'italic', 'subscript', 'superscript'],
            [{
                icon: 'mdi-format-size',
                fixedLabel: true,
                fixedIcon: true,
                list: 'no-icons',
                options: [
                  'size-1',
                  'size-2',
                  'size-3',
                  'size-4',
                  'size-5',
                ],
            }],
            [
              {
                icon: $q.iconSet.editor.font,
                fixedIcon: true,
                list: 'no-icons',
                options: [
                  'default_font',
                  'arial',
                  'arial_black',
                  'comic_sans',
                  'courier_new',
                  'impact',
                  'lucida_grande',
                  'times_new_roman',
                  'verdana',
                ],
              }
            ],
            ['hr', 'link'],
            ['quote', 'unordered', 'ordered'],
          ]"
          :fonts="{
            arial: 'Arial',
            arial_black: 'Arial Black',
            comic_sans: 'Comic Sans MS',
            courier_new: 'Courier New',
            impact: 'Impact',
            lucida_grande: 'Lucida Grande',
            times_new_roman: 'Times New Roman',
            verdana: 'Verdana',
          }"
        ></q-editor>
        <div class="q-pt-sm q-pb-none text-caption text-grey-8">Background</div>
        <q-input
        v-model="edit.value.backgroundColor"
        :rules="['anyColor']"
        class="q-pt-none"
        >
        <template v-slot:append>
          <q-icon name="mdi-palette" class="cursor-pointer">
            <q-popup-proxy cover transition-show="scale" transition-hide="scale">
              <q-color v-model="edit.value.backgroundColor"></q-color>
            </q-popup-proxy>
          </q-icon>
        </template>
      </q-input>
      <div class="q-pt-sm q-pb-none text-caption text-grey-8">Text</div>
      <q-input
        v-model="edit.value.textColor"
        :rules="['anyColor']"
        class="q-pt-none"
      >
        <template v-slot:append>
          <q-icon name="mdi-palette" class="cursor-pointer">
            <q-popup-proxy cover transition-show="scale" transition-hide="scale">
              <q-color v-model="edit.value.textColor"></q-color>
            </q-popup-proxy>
          </q-icon>
        </template>
      </q-input>
        <q-input label="Key" v-model="edit.value.sectionKey" />
        <q-input label="Sequence (opt)" v-model="edit.value.sequence" />
        <UColumnSelector v-model="edit.value.gridColumn" />
        <URowSelector v-model="edit.value.gridRow" />
      </q-card-section>
      <q-card-actions class="justify-center">
        <q-btn label="Save" color="primary" @click="save()"></q-btn>
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, watch, toRefs, toRef, reactive } from "vue";
import { useDialogPluginComponent, useQuasar } from "quasar";

import { v4 as uuidv4 } from "uuid";

import UColumnSelector from "../../ultri/UColumnSelector.vue";
import URowSelector from "../../ultri/URowSelector.vue";

const emit = defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  ...useDialogPluginComponent.emits,
  "add",
  "modify",
  "remove",
]);

const props = defineProps(["data"]);

const edit = reactive({});

const $q = useQuasar();


watch(
  () => props.data,
  () => {
    edit.value = reactive(props.data);
  },
  { immediate: true }
);

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
