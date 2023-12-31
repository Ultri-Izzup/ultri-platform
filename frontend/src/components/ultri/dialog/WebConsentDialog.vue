<template>
  <q-dialog ref="dialogRef">
    <q-card class="q-dialog-plugin">
      <q-form>
        <q-bar class="bg-primary">
          {{ $t("webConsent.dialog.title", "Cookie Settings") }}
          <q-space></q-space>

          <q-btn dense flat icon="mdi-close" v-close-popup>
            <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
          </q-btn>
        </q-bar>
        <q-tabs
          v-model="consentTab"
          dense
          class="text-grey"
          active-color="primary"
          indicator-color="primary"
          align="justify"
          narrow-indicator
        >
          <q-tab name="cookies" label="Cookies"></q-tab>
          <q-tab name="policies" label="Policies"></q-tab>
          <q-tab name="email" label="Email"></q-tab>
        </q-tabs>

        <q-tab-panels v-model="consentTab" animated>
          <q-tab-panel name="cookies">
            <q-card-section>
              <div class="dialog-header row">
                <div class="col">
                  {{ $t("webConsent.dialog.cookie.headline") }}
                </div>
              </div>
              <div v-if="authBlocked">
                <div
                  class="dialog-body text-weight-bold text-negative"
                >
                  {{
                    $t(
                      "webConsent.dialog.cookie.authRequired",
                      "You must accept the the Cookie Policy and allow Authentication Cookies to sign in."
                    )
                  }}
                </div>
              </div>
                <div v-else>
                <div class="dialog-body">
                  {{ $t("webConsent.dialog.cookie.instructions") }}
                </div>
                <div
                  v-if="!cookiePolicyAccepted"
                  class="dialog-body text-weight-bold"
                >
                  {{
                    $t(
                      "webConsent.dialog.cookie.policyRequired",
                      "You must accept the the Cookie Policy before accepting any cookies."
                    )
                  }}
                </div>
              </div>
            </q-card-section>
            <q-card-section>
              <q-toggle
                v-model="cookiePolicyAccepted"
                :label="$t('webConsent.dialog.policies.cookie.label')"
                :class="cookiePolicyAccepted ? '' : 'text-grey-6'"
              ></q-toggle>
              <q-btn
                @click="policyDialog('cookies')"
                no-caps
                flat
                label="[ View ]"
                class="text-caption"
              ></q-btn>
            </q-card-section>
            <q-card-section>
              <q-toggle
                v-model="authCookiesAccepted"
                :disable="!cookiePolicyAccepted"
                :label="$t('webConsent.dialog.cookie.authCookies.label')"
                :class="authCookiesAccepted ? '' : ' text-grey-6'"
                ><q-tooltip v-if="!cookiePolicyAccepted"
                  >You must accept the cookie policy first</q-tooltip
                ><q-tooltip v-else>Required to sign in</q-tooltip>
              </q-toggle>
            </q-card-section>
            <q-card-section>
              <q-toggle
                v-model="trackingCookiesAccepted"
                :disable="!cookiePolicyAccepted"
                color="primary"
                :label="$t('webConsent.dialog.cookie.trackingCookies.label')"
                :class="trackingCookiesAccepted ? '' : 'text-grey-6'"
                ><q-tooltip v-if="!cookiePolicyAccepted"
                  >You must accept the cookie policy first</q-tooltip
                ><q-tooltip v-else
                  >Enable analytics tracking</q-tooltip
                ></q-toggle
              >
            </q-card-section>
          </q-tab-panel>
          <q-tab-panel name="policies">
            <q-card-section>
              <div class="dialog-header row">
                <div class="col">
                  {{ $t("webConsent.dialog.policies.headline") }}
                </div>
              </div>
              <div class="dialog-body">
                {{ $t("webConsent.dialog.policies.instructions") }}
              </div>
            </q-card-section>
            <q-card-section>
              <q-toggle
                v-model="privacyPolicyAccepted"
                :label="$t('webConsent.dialog.policies.privacy.label')"
                :class="privacyPolicyAccepted ? '' : 'text-grey-6'"
              ></q-toggle>
              <q-btn
                @click="policyDialog('privacy')"
                no-caps
                flat
                label="[ View ]"
                class="text-caption"
              ></q-btn>
            </q-card-section>
          </q-tab-panel>
          <q-tab-panel name="email">
            <q-card-section>
              <div class="dialog-header row">
                <div class="col">
                  {{ $t("webConsent.dialog.emails.headline") }}
                </div>
              </div>
              <div class="dialog-body">
                {{ $t("webConsent.dialog.emails.instructions") }}
              </div>
            </q-card-section>
            <q-card-section
              :class="marketingEmailsAccepted ? '' : 'text-grey-6'"
            >
              <q-toggle
                v-model="marketingEmailsAccepted"
                :label="$t('webConsent.dialog.emails.marketingEmails.label')"
                :disable="!isSignedIn"
                ><q-tooltip v-if="!isSignedIn"
                  >You must be signed in to manage email settings</q-tooltip
                ><q-tooltip v-else
                  >We do not send many marketing emails.</q-tooltip
                ></q-toggle
              >
            </q-card-section>
          </q-tab-panel>
        </q-tab-panels>
      </q-form>
    </q-card>
    <q-dialog
      v-model="showPolicyDialog"
      maximized
      transition-show="slide-up"
      transition-hide="slide-down"
    >
      <div
        class="fit"
        :style="Screen.lt.md ? 'max-width: 98%' : 'max-width: 80%'"
      >
        <q-card class="full-width">
          <q-bar class="bg-primary">
            <q-space></q-space>

            <q-btn dense flat icon="mdi-close" v-close-popup>
              <q-tooltip>{{ $t("nav.close") }} </q-tooltip>
            </q-btn>
          </q-bar>
          <q-card-section>   <MdPreview v-model="policyData" language="en-US" /> </q-card-section>
          <q-card-section>
            <q-toggle
              v-if="currentPolicy == 'privacy'"
              v-model="privacyPolicyAccepted"
              :label="
                $t(
                  'webConsent.dialog.policies.privacy.acceptance',
                  'I accept the Privacy Policy'
                )
              "
              :class="privacyPolicyAccepted ? '' : 'text-grey-6 text-strike'"
            ></q-toggle>
            <q-toggle
              v-if="currentPolicy == 'cookies'"
              v-model="cookiePolicyAccepted"
              :label="
                $t(
                  'webConsent.dialog.policies.cookie.acceptance',
                  'I accept the Cookie Policy'
                )
              "
              :class="cookiePolicyAccepted ? '' : 'text-grey-6 text-strike'"
            ></q-toggle>
          </q-card-section>
        </q-card>
      </div>
    </q-dialog>
  </q-dialog>
</template>

<script setup>
import { storeToRefs } from "pinia";
import { ref, computed, watch } from "vue";
import { useDialogPluginComponent, Screen } from "quasar";
import { useI18n } from "vue-i18n";

import { useAuthStore } from "../../../stores/auth";
import { useWebConsentStore } from "../../../stores/webConsent";

import { MdPreview } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';

const { t } = useI18n();

const auth = useAuthStore();
const webConsentStore = useWebConsentStore();

const policyData = ref("");
const mdData = ref({
  privacy: "",
  cookies: "",
});
const currentPolicy = ref();

const { isSignedIn } = storeToRefs(auth);

const {
  authCookiesAccepted,
  trackingCookiesAccepted,
  consentTab,
  cookiePolicyAccepted,
  privacyPolicyAccepted,
  marketingEmailsAccepted,
  authRequired,
} = storeToRefs(webConsentStore);

const showPolicyDialog = ref(false);

const authBlocked = computed(() => (authRequired.value && (!authCookiesAccepted.value || !cookiePolicyAccepted.value)));

watch((authBlocked), (oldVal, newVal) => {
  if(!oldVal && newVal)
  {
    auth.setSignInRequired()
  }
})

const policyDialog = (policy) => {
  showPolicyDialog.value = true;

  currentPolicy.value = policy;

  switch (policy) {
    case "cookies":
      if (mdData.value[policy].length < 1) {
        fetch("/md/cookie-policy.md")
          .then((response) => {
            return response.text();
          })
          .then((responseBody) => {
            console.log(responseBody);
            mdData.value[policy] = responseBody;
            policyData.value = responseBody;
          });
      } else {
        policyData.value = mdData.value[policy];
      }
      break;
    case "privacy":
      if (mdData.value[policy].length < 1) {
        fetch("/md/privacy-policy.md")
          .then((response) => {
            return response.text();
          })
          .then((responseBody) => {
            mdData.value[policy] = responseBody;
            policyData.value = responseBody;
          });
      } else {
        policyData.value = mdData.value[policy];
      }
      break;
  }
};

defineEmits([
  // REQUIRED; need to specify some events that your
  // component will emit through useDialogPluginComponent()
  ...useDialogPluginComponent.emits,
]);
</script>

<style scoped lang="scss"></style>
