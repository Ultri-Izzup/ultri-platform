<template>
  <q-dialog ref="dialogRef" maximize>
    <q-card>
      <q-bar class="bg-primary">
        {{ section.title }} Item<sup
          class="q-pl-xs clickable v-ripple"
          @click="showInstructions = !showInstructions"
        >
          <q-icon name="mdi-help-circle" size="13px" />
        </sup>
        <q-space></q-space>
        <q-btn dense flat icon="mdi-close" v-close-popup="1">
          <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
        </q-btn>
      </q-bar>
      <q-card-section>
        <div
          v-if="!showInstructions"
          class="row full-width text-italic text-body1 q-pa-sm"
        >
          <span v-html="section.instructions" />
        </div>
        <q-input label="Label" v-model="editItem.label"></q-input>
        <div class="q-pt-sm q-pb-xs text-caption text-grey-8">Details</div>
        <q-editor
          v-model="editItem.details"
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
      </q-card-section>
      <q-card-actions class="row justify-evenly">
        <q-btn
          v-if="editItem.uid"
          label="Delete"
          color="secondary"
          @click="deleteItem()"
        ></q-btn>
        <q-btn label="Save" color="primary" @click="saveItem()"></q-btn>
        <q-btn label="Cancel" color="secondary" v-close-popup="1"></q-btn>
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, watch, toRefs, toValue, toRef, unref, reactive } from "vue";
import { useDialogPluginComponent, useQuasar } from "quasar";

const emit = defineEmits([
  ...useDialogPluginComponent.emits,
  "save",
  "delete",
]);

const props = defineProps(["section", "item"]);

const editItem = ref({...props.item});

watch(
  () => props.item,
  () => {
    editItem.value = {...props.item}
  },
  { immediate: true }
);

const showInstructions = ref(true);

const $q = useQuasar();

const { dialogRef, onDialogOK } = useDialogPluginComponent();

const onOKClick = () => {
  onDialogOK();
};

const saveItem = () => {
  emit('save', { sectionKey: props.section.sectionKey, item: toValue(editItem.value) } )
  onDialogOK();
};

const deleteItem = () => {
  emit('delete', props.section.sectionKey, editItem.value.uid )
  onDialogOK();
}

</script>
