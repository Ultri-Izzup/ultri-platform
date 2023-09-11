import { defineStore } from 'pinia';

import { useStorage } from '@vueuse/core';

export const useWebConsentStore = defineStore('webConsent', {
  state: () => ({
    trackingCookiesAccepted: useStorage('trackingCookiesAccepted', false),
    authCookiesAccepted: useStorage('authCookiesAccepted', false),
    privacyPolicyAccepted: useStorage('privacyPolicyAccepted', false),
    cookiePolicyDisplayed: useStorage('cookiePolicyDisplayed', false),
    cookiePolicyAccepted: useStorage('cookiePolicyAccepted', false),
    marketingEmailsAccepted: useStorage('marketingEmailsAccepted', false),
    showDialog: useStorage('showDialog', false),
    consentTab: useStorage('consentTab', 'cookies'),
    disclaimers: useStorage('disclaimers', false),
    calOPPA: useStorage('calOPPA', false),
    eula: useStorage('eula', false),
    tos: useStorage('tos', false),
    authRequired: false
  }),

  getters: {

  },

  actions: {
    $reset() {
      this.trackingCookiesAccepted = false,
      this.authCookiesAccepted = false,
      this.cookiePolicyDisplayed = false,
      this.privacyPolicyAccepted = false,
      this.cookiePolicyAccepted = false,
      this.marketingEmailsAccepted = false,
      this.tos = false,
      this.privacy = false,
      this.disclaimers = false,
      this.calOPPA = false,
      this.eula = false,
      this.showDialog = false,
      this.consentTab = 'cookies',
      this.authRequired = false
    },
    triggerDialog(tab='cookies', requireAuth=false) {
      this.consentTab = tab;
      this.showDialog = true;
      this.authRequired = requireAuth;
    }
  }
});

