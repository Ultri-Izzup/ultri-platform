import { defineStore } from 'pinia';

import { useStorage } from '@vueuse/core';

export const useColorStore = defineStore('color', {
  state: () => ({
    darkMode: useStorage('darkMode', false),
    primaryColor: useStorage('primaryColor', null),
    secondaryColor: useStorage('secondaryColor', null),
    accentColor: useStorage('accentColor', null),
    ctaColor: useStorage('ctaColor', null),
    glossy: useStorage('glossy', false),
  }),

  getters: {

  },

  actions: {
    reset() {
      this.darkMode = false;
      this.primaryColor = null;
      this.secondaryColor = null;
      this.accentColor = null;
      this.ctaColor = null;
      this.glossy = false;
    },
    setDarkMode(val) {
      this.darkMode = val;
    },
    setPrimaryColor(val) {
      this.primaryColor = val;
    },
    setSecondaryColor(val) {
      this.secondaryColor = val;
    },
    setAccentColor(val) {
      this.accentColor = val;
    },
    setCtaColor(val) {
      this.ctaColor = val;
    },
    setGlossy(val) {
      this.glossy = val;
    }
  }
});
