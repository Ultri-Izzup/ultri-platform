import { defineStore } from 'pinia';

import { useStorage } from '@vueuse/core';

export const useWebConsentStore = defineStore('webConsent', {
  state: () => ({
    cookies: useStorage('cookies', null),
    tos: useStorage('tos', null),
    privacy: useStorage('privacy', null),
    disclaimers: useStorage('disclaimers', null),
    calOPPA: useStorage('calOPPA', null),
    eula: useStorage('eula', null),
  }),

  getters: {

  },

  actions: {
    $reset() {
      this.cookies = null,
      this.tos = null,
      this.privacy = null,
      this.disclaimers = null,
      this.calOPPA = null,
      this.eula = null
    },
  }
});
