<template>
  <q-dialog ref="dialogRef" persistent>
    <q-card class="q-dialog-plugin">
      <q-form @submit="onSubmit" @reset="reset">
        <!-- Toolbar -->
        <q-bar class="dialog-qbar">
          {{ $t("circles.circleMember") }}
          <q-space></q-space>
          <q-btn dense flat icon="mdi-close" v-close-popup @click="reset">
            <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
          </q-btn>
        </q-bar>
        <q-card-section>
          <div class="row q-pb-md">
            <q-input v-model="memberName" class="full-width" :label="$t('circles.dialog.member.name')"></q-input>
          </div>
          <div class="row q-pb-md">
            <q-input v-model="memberEmail" class="full-width" :label="$t('circles.dialog.member.email')"></q-input>
          </div>
        </q-card-section>
        <q-card-actions class="justify-center">
          <q-btn :label="$t('circles.dialog.member.saveMember')" color="primary" @click="saveCircleMember()"></q-btn>
          <q-btn :label="$t('circles.dialog.cancel')" color="primary" v-close-popup @click="reset"></q-btn>
        </q-card-actions>
      </q-form>
    </q-card>
  </q-dialog>
</template>

<script setup>
import { ref, computed, watch, unref } from "vue";
import { useDialogPluginComponent } from "quasar";
import { useCircleMembersStore } from "../../../stores/circleMembers";

const circleMembersStore = useCircleMembersStore();

const memberName = ref(null)
const memberEmail = ref(null)
const memberUid = ref(null)

const reset = () => {
  memberUid.value = null;
  memberName.value = null;
  memberEmail.value = null;
};

const currentData = computed(() => {
  return circlesStore.current();
})

// currentData.value = circlesStore.current();

// watch(circlesStore.currentCircleUid, (newValue, oldValue) => {
//   currentData.value = circlesStore.current();
// });

defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  //...useDialogPluginComponent.emits,
  "ok",
]);

const onSubmit = async () => {};

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


const saveCircleMember = async () => {
  console.log('Saving circle member')

  const memberObj = {
    name: unref(memberName),
    email: unref(memberEmail),
    uid: unref(memberUid)
  }
  const currentUid = await circleMembersStore.setMember(memberObj);

  circleMembersStore.currentMemberUid = currentUid

  reset();
  onDialogOK({ member: memberObj });
}

</script>

<style scoped lang="scss"></style>
