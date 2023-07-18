import { defineStore } from 'pinia';
import { useStorage } from '@vueuse/core';

export const useNuggetStore = defineStore('nuggets', {
  state: () => ({
    nuggets: useStorage('nuggets', new Map()),
  }),
  getters: {},
  actions: {
    reset() {
      this.nuggets = new Map();
    },
  },
});
