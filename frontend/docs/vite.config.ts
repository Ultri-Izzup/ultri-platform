import type { Plugin } from 'vite';
import { defineConfig } from 'vite';

const VPLinkPatch = (): Plugin => ({
  name: 'make-all-external',
  enforce: 'pre',
  transform: (code, id) => {
    if (id.endsWith('VPLink.vue')) {
      return code.replace(/^const isExternal.*$/m, 'const isExternal = false');
    }
  },
});

export default defineConfig({
  plugins: [VPLinkPatch()],
});
