<template>
  <div class="row full-width">
    <q-card class="full-width">
      <q-card-section class="text-body1 text-bold">
        <contenteditable
          tag="div"
          :contenteditable="true"
          v-model="circleOKRStore.getOKRByUid(props.okrUid).label"
          :no-nl="true"
          :no-html="true"
          @returned="enterPressed"
        />
      </q-card-section>
      <q-card-section>
        <contenteditable
          tag="div"
          :contenteditable="true"
          v-model="circleOKRStore.getOKRByUid(props.okrUid).description"
          :no-nl="true"
          :no-html="true"
          @returned="enterPressed"
        />
      </q-card-section>
      <q-card-section>
        {{ circleOKRStore.getOKRByUid(props.okrUid).keyResults }}
      </q-card-section>
      <q-card-actions>
        <q-space />
        <q-btn @click="circleOKRStore.triggerCircleKeyResultDialog()" :label="$t('circles.okr.addKeyResult')" color="primary" />
        <q-space />
        <q-btn @click="emit('unlink')" :label="$t('circles.okr.removeLink')" color="secondary" />
        <q-space />
      </q-card-actions>
    </q-card>
    <div class="row full-width"></div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import contenteditable from "vue-contenteditable"; // Not needed it registered globally
import { useCircleOKRStore } from "../../../stores/circleOKR";

const props = defineProps({
  okrUid: String,
});

const emit = defineEmits(['unlink'])

const enterPressed = () => {};

const circleOKRStore = useCircleOKRStore();

</script>
