<template>
  <q-dialog ref="dialogRef">
    <q-card>
      <q-bar class="bg-primary">
        Canvas Section
        <q-space></q-space>
        <q-btn
          v-if="editSection.uid"
          dense
          flat
          icon="mdi-delete"
          v-close-popup
          @click="emit('remove', editSection.uid)"
          class="q-pr-sm"
        >
          <q-tooltip>{{ $t("nav.delete") }} </q-tooltip>
        </q-btn>
        <q-btn dense flat icon="mdi-close" v-close-popup @click="reset()">
          <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
        </q-btn>
      </q-bar>
      <q-card-section>
        <q-input label="Title" v-model="editSection.title" />
        <div class="q-pt-sm q-pb-xs text-caption text-grey-8">Instructions</div>
        <q-editor
          v-model="editSection.instructions"
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
        <div class="q-pt-sm q-pb-none text-caption text-grey-8">Background color</div>
        <q-input
        v-model="editSection.backgroundColor"
        :rules="['anyColor']"
        class="q-pt-none"
        >
        <template v-slot:append>
          <q-icon name="mdi-palette" class="cursor-pointer">
            <q-popup-proxy cover transition-show="scale" transition-hide="scale">
              <q-color v-model="editSection.backgroundColor"></q-color>
            </q-popup-proxy>
          </q-icon>
        </template>
      </q-input>
      <div class="q-pt-sm q-pb-none text-caption text-grey-8">Text color</div>
      <q-input
        v-model="editSection.textColor"
        :rules="['anyColor']"
        class="q-pt-none"
      >
        <template v-slot:append>
          <q-icon name="mdi-palette" class="cursor-pointer">
            <q-popup-proxy cover transition-show="scale" transition-hide="scale">
              <q-color v-model="editSection.textColor"></q-color>
            </q-popup-proxy>
          </q-icon>
        </template>
      </q-input>
        <q-input label="Key" v-model="editSection.sectionKey" />
        <q-input label="Sequence (opt)" v-model="editSection.sequence" />
        <UColumnSelector v-model="editSection.gridColumn" />
        <URowSelector v-model="editSection.gridRow" />
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

const { dialogRef, onDialogOK } = useDialogPluginComponent();

const $q = useQuasar();

const emit = defineEmits([
  ...useDialogPluginComponent.emits,
  "save",
  "delete",
]);

const props = defineProps(["section"]);

const editSection = ref({...props.section});

// console.log(editSection)

watch(
  () => props.section,
  () => {
    editSection.value = {...props.section}
  },
  { immediate: true }
);


const onOKClick = () => {
  onDialogOK();
};

const save = () => {
  emit("save", editSection.value);
  onDialogOK();
};

const reset = () => {
  //edit.value = {};
};
</script>
